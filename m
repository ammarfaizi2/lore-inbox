Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269883AbTGKLCW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 07:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269898AbTGKLCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 07:02:21 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:20755 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S269883AbTGKLCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 07:02:16 -0400
Subject: [ANNOUNCE] [Fwd: [SSI-devel] New release: OpenSSI 0.9.8]
From: "Aneesh Kumar K.V" <aneesh.kumar@digital.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       opendlm-devel <opendlm-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-qIDXMxmEvGu/4CV/X/91"
Organization: Digital India
Message-Id: <1057923000.23156.22.camel@satan.xko.dec.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 11 Jul 2003 17:00:05 +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qIDXMxmEvGu/4CV/X/91
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This was announced in the openssi mailing list. 

For those who are new to openssi 

OpenSSI (Single System Image) Clusters for Linux
================================================
The OpenSSI project leverages both Compaq's NonStop Clusters for
Unixware technology and other open source technology to provide a full,
highly available SSI environment for Linux. Goals for OpenSSI clustering
include availability, scalability and manageability, built from standard
servers. Technology pieces will include: membership, single root and
single init, cluster filesystems and DLM, single process space and
process migration, load leveling, single and shared IPC space, device
space and networking space, and single management space. The OpenSSI
project will leverage the Cluster Infrastructure (CI) for Linux project.
                                                                                
If you only have a single machine, you can play with an OpenSSI cluster
of virtual User-Mode Linux (UML) machines. For more information, see:
        http://OpenSSI.org/ssiuml-howto/index.html
                                                                                
If you have multiple machines but no shared disk hardware, you can
follow the installation instructions in docs/INSTALL. They describe how
to set up an OpenSSI cluster using our Cluster File System (CFS) for the
shared root.
                                                                                
If you have shared disk hardware, such as FCAL or shared SCSI, you can
follow the docs/INSTALL.gfs instructions to set up a cluster using the
Global File System (GFS) for the shared root.
                                                                                
-aneesh 


--=-qIDXMxmEvGu/4CV/X/91
Content-Disposition: inline
Content-Description: Forwarded message - [SSI-devel] New release: OpenSSI
	0.9.8
Content-Type: message/rfc822

Received: by diexch01.xko.dec.com  id
	<01C34785.DA25F910@diexch01.xko.dec.com>; Fri, 11 Jul 2003 13:54:31 +0530
Message-ID: <3F0E6EB7.8010202@hp.com>
From: "Watson, Brian J. (HP)" <Brian.J.Watson@hp.com>
To: OpenSSI developers <ssic-linux-devel@lists.sourceforge.net>,  OpenSSI users <ssic-linux-users@lists.sourceforge.net>
Subject: [SSI-devel] New release: OpenSSI 0.9.8
Date: Fri, 11 Jul 2003 13:30:55 +0530
MIME-Version: 1.0
List-Help: 	<mailto:ssic-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: 	<https://lists.sourceforge.net/lists/listinfo/ssic-linux-devel>,<mailto:ssic-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: 	<https://lists.sourceforge.net/lists/listinfo/ssic-linux-devel>,<mailto:ssic-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I just posted the OpenSSI 0.9.8 release on OpenSSI.org. There are RPMs 
and SRPMs for Red Hat 8. There are also source tarballs of CI and 
OpenSSI for vanilla GNU/Linux.

The RPM release now includes enhanced versions of certain base RPMs, 
such as mount and nfs-utils. The source release has been completely 
reorganized. There are new instructions for installation. This release 
features improvements to the OpenSSI-enhanced /dev filesystem and LVS. 
Furthermore, it can now migrate processes linked to libpthread, 
including Perl processes. See the release notes for more details.

Enjoy!

Brian



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
_______________________________________________
ssic-linux-devel mailing list
ssic-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ssic-linux-devel

--=-qIDXMxmEvGu/4CV/X/91--

