Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281125AbRKOW2k>; Thu, 15 Nov 2001 17:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281126AbRKOW2a>; Thu, 15 Nov 2001 17:28:30 -0500
Received: from apollo.wizard.ca ([204.244.205.22]:41485 "HELO apollo.wizard.ca")
	by vger.kernel.org with SMTP id <S281125AbRKOW2Z>;
	Thu, 15 Nov 2001 17:28:25 -0500
Subject: Re: hardware raid (adaptec 1200A)?
From: Michael Peddemors <michael@wizard.ca>
To: nbecker@fred.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <x88g07fn63s.fsf@adglinux1.hns.com>
In-Reply-To: <x88g07fn63s.fsf@adglinux1.hns.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13 (Preview Release)
Date: 15 Nov 2001 14:33:54 -0800
Message-Id: <1005863634.9918.816.camel@mistress>
Mime-Version: 1.0
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not conversant with the 1200 as such, but in any hardware raid, Linux
should always see it as a single drive.. Otherwise you simply have not
set up the RAID device correctly..

On Thu, 2001-11-15 at 12:15, nbecker@fred.net wrote:
> I'm setting up a new machine with a pair of IDE drives connected to
> adaptec 1200A controller.  I defined a RAID-0 array using the adaptec
> bios, but linux doesn't see it as a single drive.  It just sees two
> drive, hde and hdg (each at their physical sizes).  Any hints?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
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

