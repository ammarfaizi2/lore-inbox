Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWBULuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWBULuS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 06:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932710AbWBULuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 06:50:18 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:12003 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932179AbWBULuR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 06:50:17 -0500
Subject: Re: new monitor, no pwroff Q?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200602202228.05291.gene.heskett@verizon.net>
References: <200602202228.05291.gene.heskett@verizon.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 21 Feb 2006 11:54:03 +0000
Message-Id: <1140522843.840.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-02-20 at 22:28 -0500, Gene Heskett wrote:
> Greetings all;
> 
> I just got a new monitor (stinks up the place) that should respond to 
> power saving off, but I've not found where to turn this on. 

In text mode it is kernel handled (via setterm) in X you need to talk to
the X folks and/or KDE depending what on your desktop handles it

