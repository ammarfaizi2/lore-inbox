Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWJAOZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWJAOZE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 10:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWJAOZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 10:25:04 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:14573 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932191AbWJAOZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 10:25:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gU8rxtAJJc0txM0iJB7Fs3N1/IWvvY0BLAuMFOA0dUh/fg0YK4X8USXILSdum6+tNs9MP7bzabgUnpM7EOW7aEuqW6nN8DFrszCIF1J2MjOVgY+OMx3eb1L5ChEWLdWyBraeOVNFY8krpVfeCN38E0Kq4bTdUd17WUaxBoEcW/U=
Message-ID: <653402b90610010725l7862ff9fy2b1c072caedaff24@mail.gmail.com>
Date: Sun, 1 Oct 2006 16:25:02 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Stefan Richter" <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 2.6.18 V7] drivers: add lcd display support
Cc: akpm@osdl.org, "Randy Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <451FC7DC.7070909@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060930232445.59e8adf6.maxextreme@gmail.com>
	 <653402b90610010553p23819d2bsd7a07fabaee7ecf3@mail.gmail.com>
	 <451FC7DC.7070909@s5r6.in-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/06, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
>
> "LCD display" is wrong and, excuse me, dumb in *all* languages. The fact
> that it is common doesn't make it a smart thing to say or write. :-)
>

Well, not in all languages: You know, in other languages the "display"
word's first letter isn't "d", so "LCD display" looks good at least in
spanish, as we don't translate the english acronym. ;-)

>
> If you find "LCD" or "LC display" ugly to look at or hard to understand
> (IMO it is not hard to understand if it appears in a computer technology
> related context), you could write "liquid crystal display". I suppose
> you could also just write "cfag12864b display".
>

I find "LC display" ugly, not "LCD". I know in english looks bad, I'm
trying to find the best way to write it, I have no preference between
them.

I think I will choose "LCD" for all places, also the pathname: drivers/lcd/

I will wait for the V7 to get reviewed, then I will fix it for the V8.
