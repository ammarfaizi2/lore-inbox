Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263952AbTF0HM7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 03:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbTF0HM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 03:12:59 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:65435 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S263952AbTF0HM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 03:12:58 -0400
Date: Fri, 27 Jun 2003 09:27:11 +0200
From: Bruno Cornec <Bruno.Cornec@hp.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: linux-kernel@vger.kernel.org, sophie.pasquier@hp.com
Subject: Re: PROBLEM: DL760 G2 issue on 2.4.21 with Hyper-Threading
Message-ID: <20030627092711.Q9969@morley.grenoble.hp.com>
References: <C8C38546F90ABF408A5961FC01FDBF1901048896@fmsmsx405.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1901048896@fmsmsx405.fm.intel.com>; from venkatesh.pallipadi@intel.com on Thu, Jun 26, 2003 at 09:29:16AM -0700
X-Humor: Linux is to Windows what early music is to military music
X-Operating-System: Linux morley.grenoble.hp.com 2.4.20-13.7
X-Current-Uptime: 8:35pm  up 21 days,  8:46,  2 users,  load average: 0.78, 0.29, 0.17
X-HP-HOWTO-URL: http://www.HyPer-Linux.org/HP-HOWTO/current
X-eurolinux: http://eurolinux.grenoble.hp.com/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pallipadi, Venkatesh (venkatesh.pallipadi@intel.com) said:

>   Can you enable ACPI in the config and try again. With that you should be able to see all the processors.
> 

Ok, I did it.
Now the kernel just boots and doesn't go any further
cmdline is just with ide=nodma
(Only the first line indicating that the kernel is booting appears
on the screen).

Bruno.
-- 
Linux Solution Consultant         Tél: +33 476 143 278 - Fax: +33 476 146 105
HP/Intel Solution Center http://hpintelco.net Hewlett-Packard Grenoble/France
Des infos sur Linux?  http://www.HyPer-Linux.org      http://www.hp.com/linux
La musique ancienne?  http://www.musique-ancienne.org http://www.medieval.org
