Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbTFFU3D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 16:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbTFFU3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 16:29:03 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:20674 "EHLO
	gatekeeper.slim") by vger.kernel.org with ESMTP id S262271AbTFFU3C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 16:29:02 -0400
Subject: Using SATA in PATA compatible mode?
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1054932405.2156.5.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Jun 2003 22:46:45 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've read somewhere that the SATA controllers are backward compatible
with PATA controllers. Does this mean that a SATA controller can be used
with standard PATA drivers (especially the Intel ICH5)?

I have got an shiny new motherboard with SATA and a ditto SATA harddrive
just sitting unrecognized by a 2.4.20 kernel. The PATA part of my Asus
P4C800 D with my DVD-ROM on it is recognized nicely, the SATA part
however doesn't show. Is there a way around this (like with IDEx=)? I'd
really like to have linux on my new box...


Cheers,

Jurgen

