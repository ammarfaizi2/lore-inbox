Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271254AbRICFAV>; Mon, 3 Sep 2001 01:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271260AbRICFAM>; Mon, 3 Sep 2001 01:00:12 -0400
Received: from teranet244-12-200.monarch.net ([24.244.12.200]:35835 "HELO
	lustre.dyn.ca.clusterfilesystem.com") by vger.kernel.org with SMTP
	id <S271254AbRICE7w>; Mon, 3 Sep 2001 00:59:52 -0400
Date: Sun, 2 Sep 2001 22:58:49 -0600
From: "Peter J. Braam" <braam@clusterfilesystem.com>
To: intermezzo-announce@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [ANNOUNCEMENT] InterMezzo 1.0.5.1 available
Message-ID: <20010902225849.G14471@lustre.dyn.ca.clusterfilesystem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have just rolled up some packages for InterMezzo 1.0.5.1. This is a
test version ramping up for a fully stable Linux 2.4 release.  This
code is released under the GPL.

WHAT IS INTERMEZZO:

InterMezzo is a high availability file system which replicates
directory trees among systems.  It provides disconnected operation,
journal recovery and kernel level write back caching.  It can use the
rsync algorithm for synchronization.  It uses protocols somewhat
similar to Coda's. 

This release includes a kernel rpm (2.4.9-ac5). The 2.4 -ac series
includes intermezzo and this kernel includes a minor extra intermezzo
patch to pure -ac. 

DISCLAIMER:

Read the file COPYING in the distribution to see the conditions under
which this software is made available.  Please use this version at
your own risk and exercise care (back up your systems etc).  [With the
2.2.19 kernels fewer problems are known, but a 2.2.19 kernel RPM is
not included.]

WHERE TO GET IT:

You can get sources and rpms from 

ftp://ftp.inter-mezzo.org/pub/intermezzo/1.0.5.1

Documentation is included and available at:
http://www.inter-mezzo.org/

Or get it from the intermezzo project on sourceforge.  Check out the
CVS tag r1_0_5_1. 

KNOWN BUGS:

There are some known problems with full disks and interrupting
mounts.  There are also a large number of known good things about it,
such as stability under heavy i/o loads. 

THANKS: 

Shirish Phatak from Tacit Networks has made more contributions to this
release than anybody else. Bill Stearns and Gord Matzigkeit have
helped seriously as well as many others and Cluster File Systems still
coordinates the project and leads the design.

HELP NEEDED:

We could use some help: frequent packaging (there are good packaging
instructions now), bug reporting or fixing is most welcome too. 

Thanks for your interest in InterMezzo, let us know about problems.


- Peter J. Braam -
