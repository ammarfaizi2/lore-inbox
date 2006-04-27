Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbWD0M52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbWD0M52 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 08:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbWD0M52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 08:57:28 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:18560 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S964985AbWD0M51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 08:57:27 -0400
Date: Thu, 27 Apr 2006 14:57:26 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Heiko J Schick <schihei@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       linuxppc-dev@ozlabs.org, Marcus Eder <MEDER@de.ibm.com>,
       Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, schickhj@de.ibm.com
Subject: Re: [PATCH 00/16] ehca: IBM eHCA InfiniBand Device Driver
Message-ID: <20060427125726.GK32127@wohnheim.fh-wedel.de>
References: <4450B378.9000705@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4450B378.9000705@de.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 April 2006 14:05:12 +0200, Heiko J Schick wrote:
> 
> many thanks for your comments. They are very helpful for us. All
> 17 patches have to be applied, otherwise the driver won't compile.

Don't expect much cheer and rejoicing over this.  I suspect that akpm
or Linus will either want the 17 patches merged into one or have a
patchset where every single patch leaves the kernel in a working
state, including working eHCA driver.

Generally, there seemed to be a bit more SHOUTING when compared to
other kernel code.  Might be something to look at as well.

Jörn

-- 
Rules of Optimization:
Rule 1: Don't do it.
Rule 2 (for experts only): Don't do it yet.
-- M.A. Jackson 
