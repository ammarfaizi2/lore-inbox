Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286825AbSBGJig>; Thu, 7 Feb 2002 04:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286942AbSBGJiQ>; Thu, 7 Feb 2002 04:38:16 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:4622 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S286825AbSBGJiJ>;
	Thu, 7 Feb 2002 04:38:09 -0500
Date: Thu, 7 Feb 2002 10:37:51 +0100
From: Jens Axboe <axboe@suse.de>
To: Benoit Garnier <bunch@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] - 2.5.4-pre1 - I/O error on CD-ROM
Message-ID: <20020207103751.B731@suse.de>
In-Reply-To: <001d01c1afa8$620d7460$0201a8c0@cybercable.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001d01c1afa8$620d7460$0201a8c0@cybercable.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07 2002, Benoit Garnier wrote:
> 
> Since I first tried the 2.5.x serie (with 2.5.3), I got errors when
> reading from my CD-ROM :
> 
> Feb  7 00:20:44 fw kernel: end_request: I/O error, dev 16:40, sector 464
> Feb  7 00:20:45 fw kernel: hdd: cdrom_read_intr: data underrun (4294967256
> blocks)

Ok, will take a look at this today.

-- 
Jens Axboe

