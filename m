Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264818AbSLQHy4>; Tue, 17 Dec 2002 02:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264822AbSLQHyz>; Tue, 17 Dec 2002 02:54:55 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:13702 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id <S264818AbSLQHyz>; Tue, 17 Dec 2002 02:54:55 -0500
Date: Tue, 17 Dec 2002 09:02:51 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre1
Message-ID: <20021217080251.GD13175@charite.de>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50L.0212101834240.23096-100000@freak.distro.conectiva> <20021211090829.GD8741@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021211090829.GD8741@charite.de>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>:

> And, alas, I do have problems with exactly that code. Background:
> 
> I've been trying the -ac kernels for quite some time now, but on my
> new Toshiba Satellite Pro 6100 they all fail miserably.
> 
> I made three screenshots which illuminate the problem:
> http://www.stahl.bau.tu-bs.de/~hildeb/kernel/

Alan's patch in the Message with "Subject: IDE but no disks" fixes the
problem.

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
Real programmers never work 9 to 5. If any real programmers are around
at 9 am, it's because they were up all night. 

