Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbTEAOme (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 10:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbTEAOme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 10:42:34 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:33432
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261333AbTEAOm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 10:42:29 -0400
Subject: Re: Tyan 2466 SMP locks hard with 2.4.20 + heavy disk i/o yet runs
	2.2.* without problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dirk Eddelbuettel <edd@debian.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030501135228.GA19643@sonny.eddelbuettel.com>
References: <20030501135228.GA19643@sonny.eddelbuettel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051797371.21446.12.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 May 2003 14:56:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-01 at 14:52, Dirk Eddelbuettel wrote:
> Performance under 2.4.20 with ext3 + win4lin patch
>   - "Stable" until disk-heavy operation causes freeze, typically within 
>     two to three days
>   - Heavy disk use (full backup writing, diff against big tarball, bonnie++) 
>     freeze the machine hard, no ping, no sign of live
>   + memtest86 shows no problem with the ram

If you don't have a PS/2 mouse plugged into the box add one. If that
doens't help duplicate the crash without win4lin.

