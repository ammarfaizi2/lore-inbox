Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266564AbUBEUdv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 15:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266631AbUBEUdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 15:33:50 -0500
Received: from gw0.infiniconsys.com ([65.219.193.226]:61454 "EHLO
	mail.infiniconsys.com") by vger.kernel.org with ESMTP
	id S266564AbUBEUcK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 15:32:10 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Date: Thu, 5 Feb 2004 15:32:09 -0500
Message-ID: <08628CA53C6CBA4ABAFB9E808A5214CB01DB96CF@mercury.infiniconsys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Thread-Index: AcPsJocX0LYSfnIgQamxpWSnv401JQAADleg
From: "Tillier, Fabian" <ftillier@infiniconsys.com>
To: "Greg KH" <greg@kroah.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, <sean.hefty@intel.com>,
       <linux-kernel@vger.kernel.org>, <hozer@hozed.org>, <woody@co.intel.com>,
       <bill.magro@intel.com>, <woody@jf.intel.com>,
       <infiniband-general@lists.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So which is more important to the "Linux kernel" project: i386 backwards
compatibility, or consistent API and functionality across processor
architectures? ;)

- Fab


-----Original Message-----
From: Greg KH [mailto:greg@kroah.com] 
Sent: Thursday, February 05, 2004 12:28 PM
To: Tillier, Fabian
Cc: Randy.Dunlap; sean.hefty@intel.com; linux-kernel@vger.kernel.org;
hozer@hozed.org; woody@co.intel.com; bill.magro@intel.com;
woody@jf.intel.com; infiniband-general@lists.sourceforge.net
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in
theLinux kernel

On Thu, Feb 05, 2004 at 02:26:19PM -0500, Tillier, Fabian wrote:
> Do note that for non x86 architectures, the component library atomic
> abstraction is all #define to the Linux provided functions.  Only x86
> needed help because of i386 backwards compatibility which is not a
goal
> of the InfiniBand project.

But that is a goal of the "Linux kernel" project :)

greg k-h
