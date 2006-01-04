Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWADIeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWADIeN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 03:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWADIeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 03:34:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:19376 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751211AbWADIeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 03:34:12 -0500
Subject: Re: keyboard driver of 2.6 kernel
From: Arjan van de Ven <arjan@infradead.org>
To: "P.Manohar" <pmanohar@lantana.tenet.res.in>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.60.0601041359380.7341@lantana.cs.iitm.ernet.in>
References: <Pine.LNX.4.60.0601041359380.7341@lantana.cs.iitm.ernet.in>
Content-Type: text/plain
Date: Wed, 04 Jan 2006 09:33:42 +0100
Message-Id: <1136363622.2839.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-04 at 14:02 +0530, P.Manohar wrote:
> Greetings,
>      I have a small doubt in Linux kernel keyboard driver.
> In 2.4 kernels the starting fuction of keyboard driver is "handle_scancode". 
> But in 2.6 kernels the keyboard interface
> is changed drastically.  If you familiar with that can you tell me the starting 
> fuction of keyboard interace which gets
> the scancodes in 2.6 kernels.
> 
> Actually my paln is to stuff scancodes or keycodes to the keyboard buffer 
> , from there on the keyboard driver processes them.  I have done this for 
> 2.4 kernel.  I want to implement the same to 2.6 kernel.
> 
> Is there any keyloggers which are implemented for 2.6 kernels?

this is not r00tkitnewbies mailing list 

keyloggers are evil!


