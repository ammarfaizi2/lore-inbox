Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135718AbRD2L03>; Sun, 29 Apr 2001 07:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135724AbRD2L0I>; Sun, 29 Apr 2001 07:26:08 -0400
Received: from p3EE3CB32.dip.t-dialin.net ([62.227.203.50]:46609 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S135721AbRD2L0F>; Sun, 29 Apr 2001 07:26:05 -0400
Date: Sun, 29 Apr 2001 13:23:02 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.3 2.4.4pre8: aic7xxx showstopper bug fails to detect sda
Message-ID: <20010429132302.B30588@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <6C6D58C130D5D411ABF200A0C9E9216A1145B2@iserver.ingenuity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <6C6D58C130D5D411ABF200A0C9E9216A1145B2@iserver.ingenuity.com>; from RTharakan@ingenuity.com on Sat, Apr 28, 2001 at 22:20:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Apr 2001, Royans Tharakan wrote:

> SCSI subsystem driver Revision: 1.00
> aacraid raid driver version, Apr 28 2001
> percraid device detected
> Device mapped to virtual address 0xf8806000
> percraid:0 device initialization successful
> percraid:0 AacHba_ClassDriverInit complete
> scsi0 : percraid
>   Vendor: DELL      Model: PERCRAID Mirror   Rev: 0001
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> Detected scsi removable disk sda at scsi0, channel 0, id 0, lun 0
> SCSI device sda: 35544577 512-byte hdwr sectors (18199 MB)
> sda: Write Protect is off
> Partition check:
>  sda: sda1 sda2 < sda5 sda6 >
> scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.5
>         <Adaptec aic7899 Ultra160 SCSI adapter>
>         aic7899: Wide Channel B, SCSI Id=7, 32/255 SCBs

Your sda disk is attached to your RAID card, isn't it?
