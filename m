Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263760AbTBNTA0>; Fri, 14 Feb 2003 14:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264711AbTBNTA0>; Fri, 14 Feb 2003 14:00:26 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:58887 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S263760AbTBNTAZ>; Fri, 14 Feb 2003 14:00:25 -0500
Date: Fri, 14 Feb 2003 19:11:14 +0000 (UTC)
Message-Id: <20030214.191114.88638984.yoshfuji@linux-ipv6.org>
To: usagi-stable-announcement:;
CC: usagi@linux-ipv6.org
Subject: USAGI STABLE RELEASE 4.1
From: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Happy St. Valentine's Day!

We are glad to announce the [1]USAGI STABLE RELEASE 4.1, dated on the
February 14th, 2003. This is the maintenance release of the STABLE
RELEASE 4 dated on October 7th, 2002. People who use previous releases
are encouraged to upgrade to this release.

Changes from the STABLE RELEASE 4 are:
  * based on latest kernel linux-2.4.20.
  * glibc-2.3.x friendly.
  * IPsec tunnel mode support and DH Group 1 support in Pluto.
  * fixed (possible) panic in rawv6_recvmsg().
  * fixed memory leakages in getifaddrs() and if_nameindex().
  * fixed NI message format of ping6.

and so on.

You can get our complete kit which includes kernel tree, library and
applications from <ftp://ftp.linux-ipv6.org/pub/usagi/stable/kit/>.

We also provide separate patches against the main-line kernel and the
tools <ftp://ftp.linux-ipv6.org/pub/usagi/stable/split/>.

We have a plan to provide the binary packages for some distributions.
They will appear under
<ftp://ftp.linux-ipv6.org/pub/usagi/stable/package/> within several
weeks.

Some of our efforts are already in mainline kernel tree. We continue
working spliting our changes into reasonable size and trying merging
it into mainline kernel tree.

We announce the latest information on our web pages. Please check our
web site <http://www.linux-ipv6.org>.

We also manage the mailing list for USAGI users. If you have
questions, please join the mailing list. Comments and advises are also
welcome on that mailing list. Please visit
<http://www.linux-ipv6.org/ml/> for further information.

Thanks.

About USAGI Project

The USAGI Project is managed by volunteers and aims to provide better
IPv6 environment on Linux freely. We are tightly collaborating with
[2]WIDE Project, [3]KAME Project and [4]TAHI Project, and trying to
improve Linux kernel, IPv6 related libraries and IPv6 applications.
Our snapshots are released every two weeks and stable release is
released several times a year. Please check our web site
http://www.linux-ipv6.org for the latest information.

References

[1] USAGI Project       <http://www.linux-ipv6.org>
[2] WIDE Project        <http://www.wide.ad.jp>
[3] KAME Project        <http://www.kame.net>
[4] TAHI Project        <http://www.tahi.org>

Sincerely,

-- 
USAGI Project Members

