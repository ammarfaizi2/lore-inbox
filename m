Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262655AbSJBWBo>; Wed, 2 Oct 2002 18:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262656AbSJBWBo>; Wed, 2 Oct 2002 18:01:44 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:28888 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262655AbSJBWBn>;
	Wed, 2 Oct 2002 18:01:43 -0400
Date: Wed, 02 Oct 2002 15:02:56 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andreas Dilger <adilger@clusterfs.com>, Dave Hansen <haveblue@us.ibm.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH]  4KB stack + irq stack for x86
Message-ID: <388830000.1033596176@flay>
In-Reply-To: <20021002215649.GY3000@clusterfs.com>
References: <3D9B62AC.30607@us.ibm.com> <20021002215649.GY3000@clusterfs.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm a little bit worried about this patch.  Have you tried something
> like NFS-over-ext3-over-LVM-over-MD or so, which can have a deep stack?

No, I don't think we're that twisted. 
But feel free ... and have fun getting LVM to work first ;-)

IMHO, bugfixing arcane corner-case bloat issues can come later, if all normal
configs work.

M.

