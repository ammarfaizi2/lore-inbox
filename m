Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314005AbSDKKDs>; Thu, 11 Apr 2002 06:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314013AbSDKKDr>; Thu, 11 Apr 2002 06:03:47 -0400
Received: from elin.scali.no ([62.70.89.10]:43014 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S314005AbSDKKDr>;
	Thu, 11 Apr 2002 06:03:47 -0400
Date: Thu, 11 Apr 2002 09:34:43 +0200 (CEST)
From: Steffen Persvold <sp@scali.com>
To: <nfs@lists.sourceforge.net>
Subject: IRIX NFS server and Linux NFS client
In-Reply-To: <15540.60384.355250.346480@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.30.0204110928530.28565-100000@elin.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Is there any reason why my Linux NFS client (kernel 2.4.18
nfs-utils-0.3.1-13.7.2.1 from RedHat 7.2) is not able to mount a directory
exported from an IRIX server in NFSv3 (not sure which version of IRIX
yet, if this is important I will find out). NFSv2 works fine, but if I
try to force NFSv3 I get "Connection refused".

I'll appreciate any help.

Regards,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency


