Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVG1MCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVG1MCA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 08:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVG1MB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 08:01:59 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:40511 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S261411AbVG1MBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 08:01:14 -0400
Date: Thu, 28 Jul 2005 14:01:13 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: dipankar das <dipankar_dd@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: core file not generated when kernel is crashed with Sysrq key
Message-ID: <20050728120113.GB12446@harddisk-recovery.com>
References: <20050728115242.60695.qmail@web40710.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050728115242.60695.qmail@web40710.mail.yahoo.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 04:52:42AM -0700, dipankar das wrote:
> core file is not generated when kernel is crashed with
> Sysrq key ?

That's right.

>  What could be the reason for this ?

Because it wasn't designed to do so. Core files are for crashing
userland programs. There are projects for kernel crash dumps, search
the archives.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
