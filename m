Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbTK2OCR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 09:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263764AbTK2OCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 09:02:16 -0500
Received: from as13-5-5.has.s.bonet.se ([217.215.179.23]:39112 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S263460AbTK2OCP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 09:02:15 -0500
Message-ID: <3FC8A77B.9020806@stesmi.com>
Date: Sat, 29 Nov 2003 15:04:43 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: Andries Brouwer <aebr@win.tue.nl>, Szakacsits Szabolcs <szaka@sienet.hu>,
       Andrew Clausen <clausen@gnu.org>, Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
References: <20031128045854.GA1353@home.woodlands> <20031128142452.GA4737@win.tue.nl> <20031129022221.GA516@gnu.org> <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi> <20031129123451.GA5372@win.tue.nl> <200311291350.hATDo0CY001142@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200311291350.hATDo0CY001142@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> Why don't we take the opporunity to make all CHS code configurable out
> of the kernel, and define a new, more compact, partition table format
> which used LBA exclusively, and allowed more than four partitions in
> the main partition table?
> 
> I know it sounds pointless to define a new partitioning scheme when
> there are so many already in existance, but for dedicated Linux
> machines, only being able to define four partitions without resorting
> to 'extended' partitions, which store there partitioning data in other
> parts of the disk, is a needless limitation.  We could also ensure
> that there is sufficient magic in the partition table to make
> identifying it easy and reliable.

Then just select a partitioning scheme that fills those features you
request instead, as you say - there are very many out there and
you're bound to find at least ONE that has those features (I can name
a few straight off) :)

// Stefan

