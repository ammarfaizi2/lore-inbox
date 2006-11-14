Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965470AbWKNMdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965470AbWKNMdA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 07:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965290AbWKNMdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 07:33:00 -0500
Received: from wx-out-0506.google.com ([66.249.82.224]:10429 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965470AbWKNMc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 07:32:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bexe887WN4KG4WbYe2hVbrbcUplwDzgN/Jza4SJhPtVZ+nxGDddNJ1KjpI7G6zSa0Tk91FBKB4+4oUG8NNW9/zoK9O2RttgE/qMLGyfeGbPLkw6OM2VtBqA/d9wVqH/wE0mtTZPHPNFYBGEfkOM/G+JbIqfk4j48Kx/rBp1GBbU=
Message-ID: <5a4c581d0611140432j7626c175q4d09ade97f07d865@mail.gmail.com>
Date: Tue, 14 Nov 2006 13:32:59 +0100
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Mark Lord" <lkml@rtr.ca>
Subject: Re: ieee80211 & ipw2200 (ipw2100) issues
Cc: "Shawn Starr" <shawn.starr@rogers.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4558B309.2070708@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061113164025.78522.qmail@web88002.mail.re2.yahoo.com>
	 <4558B309.2070708@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/06, Mark Lord <lkml@rtr.ca> wrote:
> Shawn Starr wrote:
> > With WPA2? I have to confirm if things are still broken with ipw2200 1.1.4. I wish this was sorted out. Really, the developers seem to have vanished afaik.
>
> I'm using WPA2 CCMP+CCMP(AES) with 2.6.18.  No problems.

WPA1+TKIP in my case.

--alessandro

"...when I get it, I _get_ it"

     (Lara Eidemiller)
