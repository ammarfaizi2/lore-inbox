Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262733AbVBCME4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbVBCME4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 07:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263038AbVBCMEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 07:04:55 -0500
Received: from smtp.loomes.de ([212.40.161.2]:21181 "EHLO falcon.loomes.de")
	by vger.kernel.org with ESMTP id S262927AbVBCMCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 07:02:22 -0500
Subject: Re: Linux 2.6.11-rc3 - BT848 no signal
From: Markus Trippelsdorf <markus@trippelsdorf.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: mathieu.okuyama@free.fr, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050203113022.GK10602@bytesex>
References: <Pine.LNX.4.58.0502021824310.2362@ppc970.osdl.org>
	 <1107407987.2097.18.camel@lb.loomes.de> <87is5a0wxm.fsf@bytesex.org>
	 <1107428571.2068.4.camel@lb.loomes.de>  <20050203113022.GK10602@bytesex>
Content-Type: text/plain
Date: Thu, 03 Feb 2005 13:02:17 +0100
Message-Id: <1107432137.2110.2.camel@lb.loomes.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-03 at 12:30 +0100, Gerd Knorr wrote:

> Thanks, seems to be a initialization order bug which changes the default
> state of the tda9887 output ports.  The patch below should fix that.

Everything is working fine now. Thank you.
__  
Markus

