Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281096AbRKOV43>; Thu, 15 Nov 2001 16:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281093AbRKOV4K>; Thu, 15 Nov 2001 16:56:10 -0500
Received: from magic.adaptec.com ([208.236.45.80]:27785 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S281091AbRKOVzv>; Thu, 15 Nov 2001 16:55:51 -0500
Message-ID: <F4C5F64C4EBBD51198AD009027D61DB31C8265@otcexc01.otc.adaptec.com>
From: "Bonds, Deanna" <Deanna_Bonds@adaptec.com>
To: "'Michael Peddemors'" <michael@wizard.ca>, linux-kernel@vger.kernel.org
Subject: RE: Problem with 2.4.14 mounting i2o device as root device Adapte
	c 3200 RAID controller?
Date: Thu, 15 Nov 2001 16:55:36 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a RedHat issue.  You can find some info on
http://people.redhat.com/tcallawa/dpt/ .  We will have the official drivers
posted on our web site in a few days.  2.2.14 should not have this issue.
If it does disable the i2o subsystem and make sure our driver is enable
under Low level scsi drivers->Adaptec I2O RAID.

Deanna

