Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263983AbTK2W0v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 17:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264375AbTK2W0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 17:26:51 -0500
Received: from mail018.syd.optusnet.com.au ([211.29.132.72]:64217 "EHLO
	mail018.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263983AbTK2W0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 17:26:50 -0500
Date: Sun, 30 Nov 2003 09:31:03 +1100
From: Andrew Clausen <clausen@gnu.org>
To: John Bradford <john@grabjohn.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Szakacsits Szabolcs <szaka@sienet.hu>,
       Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Message-ID: <20031129223103.GB505@gnu.org>
References: <20031128045854.GA1353@home.woodlands> <20031128142452.GA4737@win.tue.nl> <20031129022221.GA516@gnu.org> <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi> <20031129123451.GA5372@win.tue.nl> <200311291350.hATDo0CY001142@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311291350.hATDo0CY001142@81-2-122-30.bradfords.org.uk>
X-Accept-Language: en,pt
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 29, 2003 at 01:50:00PM +0000, John Bradford wrote:
> Why don't we take the opporunity to make all CHS code configurable out
> of the kernel, and define a new, more compact, partition table format
> which used LBA exclusively, and allowed more than four partitions in
> the main partition table?

Intel's EFI GPT partition table format seems quite acceptable.

Cheers,
Andrew

