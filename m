Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291314AbSBGVMY>; Thu, 7 Feb 2002 16:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291318AbSBGVMP>; Thu, 7 Feb 2002 16:12:15 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:45560 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S291316AbSBGVME>; Thu, 7 Feb 2002 16:12:04 -0500
Date: Thu, 07 Feb 2002 05:08:43 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: mingo@elte.hu
Subject: Re: Performance of Ingo's O(1) scheduler on NUMA-Q
Message-ID: <241920000.1013087323@flay>
In-Reply-To: <23350000.1012000033@flay>
In-Reply-To: <Pine.LNX.4.33.0201211626030.12418-100000@localhost.localdomain> <119440000.1011836623@flay> <23350000.1012000033@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Measuring kernel compile times on a 16 way NUMA-Q,
adding Ingo's scheduler patch takes kernel compiles down
from 47 seconds to 31 seconds .... pretty impressive benefit.

Mike Kravetz is working on NUMA additions to Ingo's scheduler
which should give further improvements.

Martin.

