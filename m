Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262977AbTDBMHb>; Wed, 2 Apr 2003 07:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262983AbTDBMHb>; Wed, 2 Apr 2003 07:07:31 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:58372 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262977AbTDBMHa>; Wed, 2 Apr 2003 07:07:30 -0500
Date: Wed, 2 Apr 2003 14:18:49 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Badari Pulavarty <pbadari@us.ibm.com>
cc: Joel.Becker@oracle.com, <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <200303311541.50200.pbadari@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0304021413210.12110-100000@serv>
References: <200303311541.50200.pbadari@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 31 Mar 2003, Badari Pulavarty wrote:

> I have been playing with supporting 4000 disks on IA32 machines.
> There are bunch of issues we need to resolve before we could
> do that.
> 
> I am using scsi_debug to simulate 4000 disks. (Ofcourse, I had
> to hack "sd" to support more than 256 disks).

Could you please post your changes to sd.c and anything relevant to it?
Thanks.

bye, Roman

