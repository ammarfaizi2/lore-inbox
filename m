Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313199AbSC1SM0>; Thu, 28 Mar 2002 13:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313204AbSC1SMR>; Thu, 28 Mar 2002 13:12:17 -0500
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:14351 "EHLO
	rtr.ca") by vger.kernel.org with ESMTP id <S313199AbSC1SMG>;
	Thu, 28 Mar 2002 13:12:06 -0500
Message-ID: <3CA35CAF.59B20386@pobox.com>
Date: Thu, 28 Mar 2002 13:10:55 -0500
From: Mark Lord <mlord@pobox.com>
Organization: Real-Time Remedies Inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: John Summerfield <summer@os2.ami.com.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE and hot-swap disk caddies
In-Reply-To: <Pine.LNX.3.96.1020328114600.18285A-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hdparm - get/set hard disk parameters - version v4.6

Usage:  hdparm  [options] [device] ..

Options:
 -a   get/set fs readahead
 -A   set drive read-lookahead flag (0/1)
 -b   get/set bus state (0 == off, 1 == on, 2 == tristate)
 -B   get Advanced Power Management setting (1-255)
 -c   get/set IDE 32-bit IO setting
 -C   check IDE power mode status
 -d   get/set using_dma flag
 -D   enable/disable drive defect-mgmt
 -E   set cd-rom drive speed
 -f   flush buffer cache for device on exit
 -g   display drive geometry
 -h   display terse usage information
 -i   display drive identification
 -I   detailed/current information directly from drive
 -k   get/set keep_settings_over_reset flag (0/1)
 -K   set drive keep_features_over_reset flag (0/1)
 -L   set drive doorlock (0/1) (removable harddisks only)
 -m   get/set multiple sector count
 -n   get/set ignore-write-errors flag (0/1)
 -p   set PIO mode on IDE interface chipset (0,1,2,3,4,...)
 -P   set drive prefetch count
 -q   change next setting quietly
 -r   get/set readonly flag (DANGEROUS to set)
 -R   register an IDE interface (DANGEROUS)
 -S   set standby (spindown) timeout
 -t   perform device read timings
 -T   perform cache read timings
 -u   get/set unmaskirq flag (0/1)
 -U   un-register an IDE interface (DANGEROUS)
 -v   default; same as -acdgkmnru (-gr for SCSI, -adgr for XT)
 -V   display program version and exit immediately
 -w   perform device reset (DANGEROUS)
 -W   set drive write-caching flag (0/1) (DANGEROUS)
 -x   perform device for hotswap flag (0/1) (DANGEROUS)
 -X   set IDE xfer mode (DANGEROUS)
 -y   put IDE drive in standby mode
 -Y   put IDE drive to sleep
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
