Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131614AbRDCLAK>; Tue, 3 Apr 2001 07:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131600AbRDCLAA>; Tue, 3 Apr 2001 07:00:00 -0400
Received: from fw-cam.cambridge.arm.com ([193.131.176.3]:8157 "EHLO
	fw-cam.cambridge.arm.com") by vger.kernel.org with ESMTP
	id <S131158AbRDCK7v>; Tue, 3 Apr 2001 06:59:51 -0400
Message-Id: <4.3.2.7.2.20010403115233.00b97d80@cam-pop.cambridge.arm.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 03 Apr 2001 11:58:04 +0100
To: "Andrew Chan" <achan@achan.com>
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@arm.com>
Subject: Re: Promise 20267 "working" but no UDMA
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <00d601c0ba9c$d60cc700$3700a8c0@pluto>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:13 PM 4/1/01, you wrote:
>Anybody manage to get UDMA 66/100 working with an on-board Promise 20267
>chip?

I'm a bit confused by this thread. I have two PDC2067 chips in my 
fileserver, both on Ultra100 boards and connected to 4 x 30Gb IBM deskstar 
disks. I have it set up as one 15GB and one ~75Gb partition using Linux 
RAID 5, and it works fine (as far as I can tell) with this config.

I do admit I have a fifth disk that has /bin, /etc, /boot on it for the 
purposes of booting, so I can boot single user and maintain the RAID array 
when necessary.

Is the issue here about the Promise FastTrack BIOS messing things up? If 
so, why use it, rather than the Promise Ultra100 BIOS, which seems to be 
fine (again, AFAIK).

Yours,

Ruth

-- 

Ruth 
Ivimey-Cook                       ruthc@sharra.demon.co.uk
Technical 
Author, ARM Ltd              ruth.ivimey-cook@arm.com

