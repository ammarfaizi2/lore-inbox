Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbULBUNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbULBUNI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 15:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbULBUNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 15:13:07 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24036 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261749AbULBUMx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 15:12:53 -0500
Message-ID: <41AF7726.4000509@pobox.com>
Date: Thu, 02 Dec 2004 15:12:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Diego Calleja <diegocg@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance
 tests
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>	<Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>	<Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>	<Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>	<Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>	<Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>	<Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org>	<41AEB44D.2040805@pobox.com>	<20041201223441.3820fbc0.akpm@osdl.org>	<41AEBAB9.3050705@pobox.com> <20041202204838.04f33a8c.diegocg@gmail.com>
In-Reply-To: <20041202204838.04f33a8c.diegocg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja wrote:
> El Thu, 02 Dec 2004 01:48:25 -0500 Jeff Garzik <jgarzik@pobox.com>
> escribió:
> 
> 
> 
>>I'm still hoping that distros (like my employer) and orgs like OSDL will 
>>step up, and hook 2.6.x BK snapshots into daily test harnesses.
> 
> 
> Automated .deb's and .rpm's for the -bk snapshots (and yum/apt repositories)
> would be nice for all those people who run unsupported distros.

Now, that's a darned good idea...

Should be simple for rpm at least, given the "make rpm" target.  I 
wonder if we have, or could add, a 'make deb' target.

	Jeff



