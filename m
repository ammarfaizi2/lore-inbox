Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275798AbSIUQo4>; Sat, 21 Sep 2002 12:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275858AbSIUQo4>; Sat, 21 Sep 2002 12:44:56 -0400
Received: from CENTRAL.CIS.UPENN.EDU ([158.130.12.2]:640 "EHLO
	central.cis.upenn.edu") by vger.kernel.org with ESMTP
	id <S275798AbSIUQoz>; Sat, 21 Sep 2002 12:44:55 -0400
Date: Sat, 21 Sep 2002 12:49:55 -0400 (EDT)
From: Nicholas Henke <henken@seas.upenn.edu>
X-X-Sender: henken@central.cis.upenn.edu
To: Wilton Wong <wwong@harddata.com>
cc: Nicholas Henke <henken@seas.upenn.edu>,
       <BProc-users@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [BProc] related oops in 2.4.17 and 2.4.19
In-Reply-To: <20020921104213.B14274@harddata.com>
Message-ID: <Pine.GSO.4.44.0209211249240.18289-100000@central.cis.upenn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nope -- all adaptec:
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs


On Sat, 21 Sep 2002, Wilton Wong wrote:

> Are you running a symbois/LSI based SCSI controller ? just wondering, becaise
> we had a whole bunch of "running short of DMA buffer" errors untill we switched
> to the newer sym83cxx driver.. we woulget a whole bunch of these errors after a
> random amount of disk activity and then boom we would oops..
>
> - Wilton
>

