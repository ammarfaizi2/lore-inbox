Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265262AbTBBN46>; Sun, 2 Feb 2003 08:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265270AbTBBN46>; Sun, 2 Feb 2003 08:56:58 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:42890 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265262AbTBBN46>;
	Sun, 2 Feb 2003 08:56:58 -0500
Date: Sun, 2 Feb 2003 15:05:54 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>,
       "John W. M. Stevens" <john@betelgeuse.us>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Defect (Bug) Report
Message-ID: <20030202140554.GR31566@suse.de>
References: <20030202011223.GC5432@morningstar.nowhere.lie> <1044178961.16853.9.camel@irongate.swansea.linux.org.uk> <20030202124911.GC30830@arthur.ubicom.tudelft.nl> <1044195694.16853.22.camel@irongate.swansea.linux.org.uk> <20030202133501.GA32041@arthur.ubicom.tudelft.nl> <1044197556.16853.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1044197556.16853.25.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 02 2003, Alan Cox wrote:
> Another approach would be to write a replacement ide_build_sglist for
> the AMD76x which bounces the problem page.

Irk, that sounds way ugly.

-- 
Jens Axboe

