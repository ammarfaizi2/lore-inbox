Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317072AbSGNUQF>; Sun, 14 Jul 2002 16:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317073AbSGNUQE>; Sun, 14 Jul 2002 16:16:04 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:38917 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317072AbSGNUQC>; Sun, 14 Jul 2002 16:16:02 -0400
Date: Sun, 14 Jul 2002 17:18:35 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Joerg Schilling <schilling@fokus.gmd.de>
cc: Richard.Zidlicky@stud.informatik.uni-erlangen.de, <andersen@codepoet.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <200207142013.g6EKDJb5019442@burner.fokus.gmd.de>
Message-ID: <Pine.LNX.4.44L.0207141718130.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jul 2002, Joerg Schilling wrote:

> BTW: did you ever look at Solaris / HP-UX, ... and the way they
> name disks?
>
> someting like: /dev/{r}dsk/c0t0d0s0
> This is SCSI bus, target, lun and slice.

I wonder what they'll change it to in order to support
network attached storage.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

