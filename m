Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293031AbSBVWpv>; Fri, 22 Feb 2002 17:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293032AbSBVWpl>; Fri, 22 Feb 2002 17:45:41 -0500
Received: from smtp-2.llnl.gov ([128.115.250.82]:7073 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id <S293031AbSBVWp3>;
	Fri, 22 Feb 2002 17:45:29 -0500
Date: Fri, 22 Feb 2002 14:45:22 -0800 (PST)
From: "Tom Epperly" <tepperly@llnl.gov>
X-X-Sender: epperly@tux06.llnl.gov
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: RH7.2 running 2.4.9-21-SMP (dual Xeon's) yields "Illegal
In-Reply-To: <E16dz1I-0007ys-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0202221444120.3017-100000@tux06.llnl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002, Alan Cox wrote:

> Possibly one hardware thing to try (depending on who and how the box is
> maintained) is swapping the cpus over and seeing if it then works single
> cpu..

I tried swapping the cpus (i.e. swapping chips), and it still runs fine 
non-SMP.

Tom

--
------------------------------------------------------------------------
Tom Epperly
Center for Applied Scientific Computing   Phone: 925-424-3159
Lawrence Livermore National Laboratory      Fax: 925-424-2477
L-661, P.O. Box 808, Livermore, CA 94551  Email: tepperly@llnl.gov
------------------------------------------------------------------------

