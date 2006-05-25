Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030353AbWEYTHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbWEYTHN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 15:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbWEYTHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 15:07:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40380 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030353AbWEYTHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 15:07:11 -0400
Date: Thu, 25 May 2006 12:06:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Kyle McMartin <kyle@mcmartin.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add compile domain (was: Re: [PATCH] Well, Linus seems
 to like Lordi...)
In-Reply-To: <200605251954.06227.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.64.0605251203490.5623@g5.osdl.org>
References: <20060525141714.GA31604@skunkworks.cabal.ca>
 <Pine.LNX.4.61.0605252027380.13379@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0605251146260.5623@g5.osdl.org> <200605251954.06227.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 25 May 2006, Alistair John Strachan wrote:
> 
> This is probably a broken configuration, but it would cause a regression for 
> me:
> 
> [alistair] 19:53 [~] hostname
> damocles
> 
> [alistair] 19:52 [~] hostname --fqdn
> localhost

Oh, wow.

So much for that idea.

			Linus
