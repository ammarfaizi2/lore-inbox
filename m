Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966435AbWKTS43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966435AbWKTS43 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966436AbWKTS43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:56:29 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:32163 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S966435AbWKTS42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:56:28 -0500
Message-ID: <4561FA5B.3060702@s5r6.in-berlin.de>
Date: Mon, 20 Nov 2006 19:56:27 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Randy Dunlap <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>, zippel@linux-m68k.org,
       jejb <james.bottomley@steeleye.com>
Subject: Re: how to handle indirect kconfig dependencies
References: <20061116200741.fb607fe4.randy.dunlap@oracle.com> <455DBF3D.40801@s5r6.in-berlin.de> <20061120181319.GX31879@stusta.de>
In-Reply-To: <20061120181319.GX31879@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> "All of the various shipped tools ... need to be fixed" is a bit 
> misleading since one of the features of the 2.6 kconfig is that this 
> code is shared by all tools.

All the better, the job will be quickly done then.
-- 
Stefan Richter
-=====-=-==- =-== =-=--
http://arcgraph.de/sr/
