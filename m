Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281795AbRLLSbW>; Wed, 12 Dec 2001 13:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281797AbRLLSbM>; Wed, 12 Dec 2001 13:31:12 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:65036 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S281795AbRLLSa4>; Wed, 12 Dec 2001 13:30:56 -0500
Date: Wed, 12 Dec 2001 15:14:17 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: John Huttley <john@mwk.co.nz>
Cc: linux kernel <linux-kernel@vger.kernel.org>, acpi-devel@sourceforge.net,
        "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: [2.4.16 bug] Major failure
In-Reply-To: <1008146872.1458.1.camel@albatross.hisdad.org.nz>
Message-ID: <Pine.LNX.4.21.0112121513330.27256-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12 Dec 2001, John Huttley wrote:

> Reprise; This is a system with a TNT2 video card,scsi and 2 cpus.
> It locks up with acpi on, when switching vc's.(as described on lkml)
> 
> I have now established that no problem occurs when compiled as UP system.
> This is true if acpi is modules or compiled in.
> 
> 
> Trying a different compiler isn't feasible for me.

A have an ACPI update pending for 2.4.18pre1: It may fix your problem.

Andrew? 

