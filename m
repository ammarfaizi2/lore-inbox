Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbUKDNLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbUKDNLp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 08:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbUKDNLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 08:11:45 -0500
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:62902 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S262211AbUKDNKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 08:10:37 -0500
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org, Jan Knutar <jk-lkml@sci.fi>,
       Tom Felker <tfelker2@uiuc.edu>
Subject: Re: is killing zombies possible w/o a reboot?
References: <200411030751.39578.gene.heskett@verizon.net>
	<200411040657.10322.gene.heskett@verizon.net>
	<200411041412.42493.jk-lkml@sci.fi>
	<200411040739.01699.gene.heskett@verizon.net>
From: Doug McNaught <doug@mcnaught.org>
Date: Thu, 04 Nov 2004 08:10:32 -0500
In-Reply-To: <200411040739.01699.gene.heskett@verizon.net> (Gene Heskett's
 message of "Thu, 4 Nov 2004 07:39:01 -0500")
Message-ID: <87wtx1220n.fsf@asmodeus.mcnaught.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/20.7 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> writes:

> [root@coyote linux-2.6.10-rc1-bk13]# grep SYSRQ .config
> CONFIG_MAGIC_SYSRQ=y

Did you also enable it in /proc? 

-Doug
