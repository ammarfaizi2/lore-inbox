Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268414AbTBYVQe>; Tue, 25 Feb 2003 16:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268382AbTBYVOs>; Tue, 25 Feb 2003 16:14:48 -0500
Received: from mail.williamewood.com ([63.98.123.93]:36517 "EHLO
	mail.williamewood.com") by vger.kernel.org with ESMTP
	id <S268354AbTBYVMn>; Tue, 25 Feb 2003 16:12:43 -0500
From: Emmett Pate <emmett@epate.com>
Organization: EPate & Associates, Inc.
To: linux-kernel@vger.kernel.org
Subject: Re: rootfs on nfs : oops 2.5.63
Date: Tue, 25 Feb 2003 16:22:55 -0500
User-Agent: KMail/1.5
References: <20030225151337.358a6ee6.bert@ovh.net>
In-Reply-To: <20030225151337.358a6ee6.bert@ovh.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302251622.55217.emmett@epate.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having the same problem.

On my notebook (wireless PCMCIA, D-Link DWL650), 2.5.63 oopses immediately on 
trying to mount an NFS filesystem.  On my desktop it works fine.  I can't 
find any kernel configuration differences that look obvious.  I'll be glad to 
forward any relevant parts of the .config if it will be helpful.

I've read elsewhere that there's a simple patch that fixes this, but I haven't 
been able to find it anywhere.

Emmett Pate


On Tuesday 25 February 2003 09:13 am, Bertrand wrote:
> Hello,
>
> I got a diskless station and i wanted to test the 2.5.* series.
>
> I got an Oops when the kernel tries to mount the rootfs on nfs.
>
> The kernel is build without modules, without ide, without scsi, with  nfs
> and root on nfs option, devfs.
>
> The oops is shown bellow.
>
> Thank for advice.
>
> 			Bert.

