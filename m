Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281132AbRKOWhK>; Thu, 15 Nov 2001 17:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281139AbRKOWhB>; Thu, 15 Nov 2001 17:37:01 -0500
Received: from apollo.wizard.ca ([204.244.205.22]:43533 "HELO apollo.wizard.ca")
	by vger.kernel.org with SMTP id <S281132AbRKOWgw>;
	Thu, 15 Nov 2001 17:36:52 -0500
Subject: RE: Problem with 2.4.14 mounting i2o device as root device Adapte c
	3200 RAID controller?
From: Michael Peddemors <michael@wizard.ca>
To: "Bonds, Deanna" <Deanna_Bonds@adaptec.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F4C5F64C4EBBD51198AD009027D61DB31C8265@otcexc01.otc.adaptec.com>
In-Reply-To: <F4C5F64C4EBBD51198AD009027D61DB31C8265@otcexc01.otc.adaptec.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13 (Preview Release)
Date: 15 Nov 2001 14:42:20 -0800
Message-Id: <1005864141.9959.824.camel@mistress>
Mime-Version: 1.0
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Confirm.. I am speaking of the 2.4.14 kernel, not the 2.2.14 kernel..
And I am trying to compile support directly into the kernel, without
using modules..

The default kernel with 7.2 doens't work with more than 512 MG Ram for
some reason, as it is having IO problems, and that is why I am trying to
chase this down

On Thu, 2001-11-15 at 13:55, Bonds, Deanna wrote:
> This is a RedHat issue.  You can find some info on
> http://people.redhat.com/tcallawa/dpt/ .  We will have the official drivers
> posted on our web site in a few days.  2.2.14 should not have this issue.
> If it does disable the i2o subsystem and make sure our driver is enable
> under Low level scsi drivers->Adaptec I2O RAID.
> 
> Deanna
> 
> 
-- 
"Catch the Magic of Linux..."
--------------------------------------------------------
Michael Peddemors - Senior Consultant
LinuxAdministration - Internet Services
NetworkServices - Programming - Security
Wizard IT Services http://www.wizard.ca
Linux Support Specialist - http://www.linuxmagic.com
--------------------------------------------------------
(604)589-0037 Beautiful British Columbia, Canada

