Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVGUSm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVGUSm1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 14:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVGUSm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 14:42:26 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:63351 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261831AbVGUSmZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 14:42:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X2JEbxwSw8y3yN3TAHV8A5KkMfOuPG/ybsZOUAF4UYwf//bfdmnKdnbEAYPQ1O2iXN+GkkBS3DXpcelfxFzi4g1XipCFsWanT0qEiLTLmFNJnzVRI5zh8ihz5rXkAHAl/du3k77VwlPIN5rmZr/jf9W20nmuseTcLmxxAQjUnz0=
Message-ID: <9a874849050721114227f3c6a7@mail.gmail.com>
Date: Thu, 21 Jul 2005 20:42:14 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: kernel guide to space
Cc: Paul Jackson <pj@sgi.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux@horizon.com, linux-kernel@vger.kernel.org
In-Reply-To: <3FC51285-941F-48B6-B5A9-1BBE95CCD816@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050714011208.22598.qmail@science.horizon.com>
	 <FD559B50-FB1E-4478-ACF4-70E4DB7A0176@mac.com>
	 <Pine.LNX.4.61.0507200715290.9066@yvahk01.tjqt.qr>
	 <20050720174521.73c06bce.pj@sgi.com>
	 <3FC51285-941F-48B6-B5A9-1BBE95CCD816@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/05, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> On Jul 20, 2005, at 20:45:21, Paul Jackson wrote:
[...snip...]
> *cough* TargetStatistics[TargetID].HostAdapterResetsCompleted *cough*
> 
> I suspect linus would be willing to accept a few cleanup patches for the
> BusLogic.c file.  Perhaps even one that renames BusLogic.c to buslogic.c
> like all the other files in the source tree, instead of using nasty
> StudlyCaps all over :-D
> 

To avoid people doing duplicate work, I just want to say that I've
started doing a CodingStyle/whitespace/VariableAndFunctionNaming
cleanup of the BusLogic driver, I'll send the patches to LKML in a few
hours.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
