Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319361AbSIFTmg>; Fri, 6 Sep 2002 15:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319362AbSIFTmf>; Fri, 6 Sep 2002 15:42:35 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:31424 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319361AbSIFTmf>;
	Fri, 6 Sep 2002 15:42:35 -0400
Date: Fri, 06 Sep 2002 12:45:39 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Nivedita Singhvi <niv@us.ibm.com>, Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
Message-ID: <65179883.1031316338@[10.10.2.3]>
In-Reply-To: <1031339954.3d78ffb257d22@imap.linux.ibm.com>
References: <1031339954.3d78ffb257d22@imap.linux.ibm.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Tthere is some cacheline thrashing hurting the NUMA 
> more than other systems here too..

There is no NUMA here ... the clients are 4 single node SMP 
systems. We're using the old quads to make them, but they're 
all split up, not linked together into one system.
Sorry if we didn't make that clear.

M.

