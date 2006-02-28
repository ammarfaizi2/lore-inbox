Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932724AbWB1X6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932724AbWB1X6e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 18:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbWB1X6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 18:58:33 -0500
Received: from greensrv.RZ.UniBw-Muenchen.de ([137.193.10.35]:23533 "EHLO
	GreenSrv.rz.unibw-muenchen.de") by vger.kernel.org with ESMTP
	id S932701AbWB1X6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 18:58:33 -0500
X-Remarks: If SPAM is relayed via GreenSrv.rz.unibw-muenchen.de to outside of unibw-muenchen.de, please report it to abuse@unibw-muenchen.de
Subject: Max mem space per process under  2.6.13-15.7-smp
From: Kai Lampka <kilampka@gmail.com>
Reply-To: kilampka@gmail.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 01 Mar 2006 00:55:47 +0100
Message-Id: <1141170947.23172.18.camel@pclampka.informatik.unibw-muenchen.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to bother, 
but what is the maximum amount of RAM that a *single* (!) process can
address under a Kernel version 2.6.13-15.7-smp, with 

CONFIG_HIGHMEM64G=y
CONFIG_HIGHMEM=y
CONFIG_X86_PAE=y

It seems that I can not get over 3 Gig border, but i need to, to solve
my numerical problems :(.


Greetings Kai

