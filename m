Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbVGHKhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbVGHKhe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 06:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVGHKhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 06:37:17 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:17491 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S262476AbVGHKfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 06:35:30 -0400
Date: Fri, 8 Jul 2005 12:35:29 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Guillermo =?iso-8859-1?Q?L=F3pez?= Alejos <glalejos@gmail.com>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Developing a filesystem
Message-ID: <20050708103529.GF17214@harddisk-recovery.com>
References: <4fec73ca05070803144da4b3c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4fec73ca05070803144da4b3c1@mail.gmail.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 12:14:56PM +0200, Guillermo López Alejos wrote:
> Now I'm writing my own dummyfs (based on ramfs) to know how this
> works, but I'm having problems compiling it; I need to include the
> "linux/fs.h" header file to have access to some structures definitions
> (such as struct file_system_type), but this is giving me some errors.
> So I think that I have to integrate my code with the kernel sources to
> make it compile.

Have a look at http://lwn.net/Articles/21823/ "Compiling external
modules".


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
