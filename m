Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262202AbRFGRRF>; Thu, 7 Jun 2001 13:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262239AbRFGRQ4>; Thu, 7 Jun 2001 13:16:56 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:38671 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S262215AbRFGRQo>;
	Thu, 7 Jun 2001 13:16:44 -0400
Message-ID: <20010607191645.A17205@win.tue.nl>
Date: Thu, 7 Jun 2001 19:16:45 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Nico Schottelius <nicos@pcsystems.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: scsi disk defect or kernel driver defect ?
In-Reply-To: <3B1FAA63.130E556A@pcsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3B1FAA63.130E556A@pcsystems.de>; from Nico Schottelius on Thu, Jun 07, 2001 at 06:22:59PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2001 at 06:22:59PM +0200, Nico Schottelius wrote:

>  0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
>  I/O error: dev 08:01, sector 127304
> SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
> [valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
> ASC=47 ASCQ= 0
> Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 
>  I/O error: dev 08:01, sector 127312

Aborted command: SCSI parity error.

