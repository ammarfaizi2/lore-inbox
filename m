Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279704AbRKFP6e>; Tue, 6 Nov 2001 10:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279708AbRKFP6P>; Tue, 6 Nov 2001 10:58:15 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:40675 "EHLO softhome.net")
	by vger.kernel.org with ESMTP id <S279704AbRKFP6J>;
	Tue, 6 Nov 2001 10:58:09 -0500
Message-ID: <05fa01c166dc$2ea9e910$7253e59b@megatrends.com>
Reply-To: "Venkatesh Ramamurthy" <venkateshr@ami.com>
From: "Venkatesh Ramamurthy" <venkateshr@softhome.net>
To: "Roy Sigurd Karlsbakk" <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0111061612570.23908-100000@mustard.heime.net>
Subject: Re: Mylex/Compaq RAID controller placement in config
Date: Tue, 6 Nov 2001 11:00:39 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I know it might seem silly, but as to make things clearer for most
> users/admins, wouldn't it be better to just call them SCSI controllers, as
> they all indeed connect SCSI drives to the host?

Eventhough they connect SCSI Drives, the fact is that they are totally
different beast from the OS/driver perspective.

