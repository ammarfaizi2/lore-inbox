Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423378AbWBBIaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423378AbWBBIaa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 03:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423379AbWBBIaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 03:30:30 -0500
Received: from mail.topfen.net ([212.24.114.150]:2797 "EHLO mail.topfen.net")
	by vger.kernel.org with ESMTP id S1423378AbWBBIa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 03:30:29 -0500
Date: Thu, 2 Feb 2006 09:30:27 +0100
From: JG <jg@cms.ac>
To: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 100% cpu usage (kjournald, pdflush) with encrypted disks
 (dm-crypt)
Message-ID: <20060202093027.06b8725f@x90.0x4a47.net>
In-Reply-To: <200602012250.53465.G.Ohrner@post.rwth-aachen.de>
References: <20060201220752.382b1927@x90.0x4a47.net>
	<200602012250.53465.G.Ohrner@post.rwth-aachen.de>
X-Mailer: Sylpheed-Claws 2.0.0-rc4 (GTK+ 2.8.8; i686-pc-linux-gnu)
X-Operating-System: Gentoo 1.4 ;)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

> Especially if you copy from one encrypted device to another, so the
> data also has to be decrypted first.

thanks for the answer! i've been using encrypted root disks for quite
some time now and didn't see much performance loss or an increase in cpu
usage. i just wanted to be sure it's the en/decrypting between
different disks and not some kernel problem :)

JG
