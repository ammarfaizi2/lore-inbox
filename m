Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbTKTWdR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 17:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbTKTWcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 17:32:20 -0500
Received: from AGrenoble-101-1-3-115.w193-253.abo.wanadoo.fr ([193.253.251.115]:8327
	"EHLO awak") by vger.kernel.org with ESMTP id S263008AbTKTWcQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 17:32:16 -0500
Subject: Re: OT: why no file copy() libc/syscall ??
From: Xavier Bestel <xavier.bestel@free.fr>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: Florian Weimer <fw@deneb.enyo.de>, Valdis.Kletnieks@vt.edu,
       Daniel Gryniewicz <dang@fprintf.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <03112013081700.27566@tabby>
References: <1068512710.722.161.camel@cube> <03111209360001.11900@tabby>
	 <20031120172143.GA7390@deneb.enyo.de>  <03112013081700.27566@tabby>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1069367504.8945.55.camel@bip.parateam.prv>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 20 Nov 2003 23:31:45 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu 20/11/2003 à 20:08, Jesse Pollard a écrit :

> 1. what happens if the copy is aborted?
> 2. what happens if the network drops while the remote server continues?
> 3. what about buffer synchronization?
> 4. what errors should be reported ?
> 5. what happens when the syscall is interupted? Especially if the remote
>    copy may take a while (I've seen some require an hour or more - worst
>    case: days due to a media error (completed after the disk was replaced)).
> 6. what about a client opening the copy before it is finished copying?

7. How to report progress with your average file manager ?

