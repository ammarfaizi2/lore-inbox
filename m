Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270405AbTGRVkZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 17:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271883AbTGRVkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 17:40:20 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:46807
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S271850AbTGRVkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 17:40:00 -0400
Subject: Re: Linux 2.6.0-test1 Ext3 Ooops. Reboot needed.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Ricardo Galli <gallir@uib.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030718142720.40983f6a.akpm@osdl.org>
References: <200307181228.40142.gallir@uib.es>
	 <20030718140019.4f6667bd.akpm@osdl.org> <200307182313.23288.gallir@uib.es>
	 <20030718142720.40983f6a.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058565114.19511.89.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Jul 2003 22:51:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-07-18 at 22:27, Andrew Morton wrote:
> > $ apt-cache show fam
> 
> I was attacked by dselect as a small child and have since avoided debian. 
> Is there a tarball anywhere?

Its standard in other systems too

%rpm -qi fam
Name        : fam                          Relocations: (not
relocateable)
Version     : 2.6.8                             Vendor: Red Hat, Inc.
Release     : 9                             Build Date: Fri 31 Jan 2003
15:22:04 GMT
Install Date: Wed 02 Apr 2003 19:18:31 BST      Build Host:
stripples.devel.redhat.com
Group       : System Environment/Daemons    Source RPM:
fam-2.6.8-9.src.rpm
Size        : 185235                           License: GPL/LGPL
Signature   : DSA/SHA1, Mon 24 Feb 2003 05:47:28 GMT, Key ID
219180cddb42a60e
Packager    : Red Hat, Inc. <http://bugzilla.redhat.com/bugzilla>
URL         : http://oss.sgi.com/projects/fam/
Summary     : FAM, the File Alteration Monitor.
Description :
FAM, the File Alteration Monitor, provides a daemon and an API which
applications can use for notification of changes in specific files or
directories.

