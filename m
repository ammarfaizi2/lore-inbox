Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269026AbTCAUpm>; Sat, 1 Mar 2003 15:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269027AbTCAUpm>; Sat, 1 Mar 2003 15:45:42 -0500
Received: from franka.aracnet.com ([216.99.193.44]:26074 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S269026AbTCAUpk>; Sat, 1 Mar 2003 15:45:40 -0500
Date: Sat, 01 Mar 2003 12:55:49 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Anton Blanchard <anton@samba.org>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       cliffw@osdl.org, akpm@zip.com.au, slpratt@austin.ibm.com,
       levon@movementarian.org, haveblue@us.ibm.com
Subject: Re: [PATCH] documentation for basic guide to profiling
Message-ID: <3200000.1046552148@[10.10.2.4]>
In-Reply-To: <20030301175114.GA30911@codemonkey.org.uk>
References: <8550000.1046419962@[10.10.2.4]> <20030228002935.256ffa98.akpm@digeo.com> <20030228112238.GJ4911@codemonkey.org.uk> <20030228152838.GB32449@gtf.org> <20010101052723.GB22212@krispykreme> <447430000.1046473881@flay> <20030301175114.GA30911@codemonkey.org.uk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --start implies starting the daemon if it isn't started
> already.

I think John suggested to do those seperately, to minimise overhead
or something.
 
>  > +dump output	oprofpp -dl -i /boot/vmlinux  >  output_file
> 
> opcontrol --dump
> 
> op_time -l is also worth adding to this doc imo.

OK, will add.

M.

