Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVDMQJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVDMQJO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 12:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVDMQJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 12:09:14 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:10054 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261384AbVDMQEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 12:04:01 -0400
Date: Wed, 13 Apr 2005 18:04:00 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Oliver Korpilla <Oliver.Korpilla@gmx.de>
Cc: debian-kernel@lists.debian.org, debian-toolchain@lists.debian.org,
       linux-gcc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Crosspost] GNU/Linux userland?
Message-ID: <20050413160400.GF13178@harddisk-recovery.com>
References: <425D75AF.7080802@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425D75AF.7080802@gmx.de>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 09:40:31PM +0200, Oliver Korpilla wrote:
> I wondered if there is a project or setup that does allow me to build a 
> GNU/Linux userland including kernel, build environment, basic tools with 
> a single script just as you can in NetBSD (build.sh) or FreeBSD (make 
> world).

Try uclibc buildroot, see http://www.uclibc.org/toolchains.html .


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
