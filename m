Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264565AbTLCNMT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 08:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264566AbTLCNMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 08:12:19 -0500
Received: from mlf.linux.rulez.org ([192.188.244.13]:23301 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S264565AbTLCNMS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 08:12:18 -0500
Date: Wed, 3 Dec 2003 14:07:06 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Andrew Clausen <clausen@gnu.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
In-Reply-To: <20031203115404.GE1810@gnu.org>
Message-ID: <Pine.LNX.4.21.0312031316550.28298-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Dec 2003, Andrew Clausen wrote:
> 
> Can you elaborate?  Autodetect what?  Autodetect if the BIOS supports LBA?

Autodetect to boot from the boot controller's miniport driver or using
BIOS. It should have been mentioned in one of the Microsoft articles I
referred.

	Szaka

