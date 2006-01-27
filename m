Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWA0OPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWA0OPQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 09:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWA0OPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 09:15:15 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:50627 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751099AbWA0OPP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 09:15:15 -0500
Date: Fri, 27 Jan 2006 15:15:13 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Documentation for /dev/tun
Message-ID: <20060127141513.GE3673@harddisk-recovery.com>
References: <20060126140402.GB13403@kestrel> <Pine.LNX.4.58.0601261543000.15286@twin.jikos.cz> <20060127091758.GA6646@kestrel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127091758.GA6646@kestrel>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 10:17:58AM +0100, Karel Kulhavy wrote:
> Why is man ttyS present and man tun missing? Is there any rule which says
> which devices should have manpage and which not?

Because the manpages are not maintained by the linux-kernel folks, but
by the manpages editor. Feel free to send a patch to the manpages
maintainer.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
