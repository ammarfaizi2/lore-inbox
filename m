Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263438AbTCNS0x>; Fri, 14 Mar 2003 13:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263441AbTCNS0x>; Fri, 14 Mar 2003 13:26:53 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:55459 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263438AbTCNS0w>; Fri, 14 Mar 2003 13:26:52 -0500
Date: Fri, 14 Mar 2003 10:27:45 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Eli Carter <eli.carter@inet.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: kgdb (kernel debugger)
Message-ID: <122350000.1047666465@flay>
In-Reply-To: <3E7111C6.9070702@inet.com>
References: <3E7111C6.9070702@inet.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hey! Watch where you point that flame-thrower!
> 
> At the risk of stoking those old fires:
> Has anyone looked into getting kgdb working on 2.5?  On any architecture?  (I'm mostly interested in XScale, but I thought I'd start here in the hope that another arch has done the heavy lifting. ;) )

It does already, it's in both current -mm and -mjb trees. There was a 
fancy new version floating around at one point, not sure what happened
to that, but the old one works fine.

M.

