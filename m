Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129295AbQKYPgt>; Sat, 25 Nov 2000 10:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129434AbQKYPgj>; Sat, 25 Nov 2000 10:36:39 -0500
Received: from d06lmsgate-2.uk.ibm.com ([195.212.29.2]:28327 "EHLO
        d06lmsgate-2.uk.ibm.com") by vger.kernel.org with ESMTP
        id <S129295AbQKYPga>; Sat, 25 Nov 2000 10:36:30 -0500
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: dprobes@oss.lotus.com, linux-kernel@vger.kernel.org
Message-ID: <802569A2.0052F47D.00@d06mta06.portsmouth.uk.ibm.com>
Date: Sat, 25 Nov 2000 15:05:17 +0000
Subject: anounce: Universal dynamic trace for Linux
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



You can now use IBM's DProbes with Opersys' Linux Trace Toolkit to provide
a universal (dynamic) tracing capability for Linux.

It is universal because it provides a common tracing mechanism for all
executables whether in user or kernel space. It is dynamic because
tracepoints are defined and applied dynamically to object modules as
probepoints using DProbes - no source code modification is required.

To use dyamic trace you will require version 1.2 of DProbes, or later from
http://oss.software.ibm.com/
and LTT version 0.9.4pre4 or later from http://www.opersys.com/

The DProbes kernel patch will need to be compiled with correct
configuration options to enable it to work with LTT. See the respective
installation instructions in each package for more details.


Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
