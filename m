Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264419AbRFIAjP>; Fri, 8 Jun 2001 20:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264421AbRFIAjF>; Fri, 8 Jun 2001 20:39:05 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3589 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264419AbRFIAiu>; Fri, 8 Jun 2001 20:38:50 -0400
Subject: Re: question about scsi generic behavior
To: hiren_mehta@agilent.com
Date: Sat, 9 Jun 2001 01:37:16 +0100 (BST)
Cc: chamb@almaden.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880AA9@xsj02.sjs.agilent.com> from "hiren_mehta@agilent.com" at Jun 08, 2001 06:13:30 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E158Wke-0003S5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hardcoding  of block size to 512 bytes for disk devices is what currently 
> either the block device driver or the sd driver is doing. Because, if

I'm using 2048 byte block sized scsi media just fine. I've not tried using
sg on the same device

