Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWE3ObV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWE3ObV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 10:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWE3ObU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 10:31:20 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:61322 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932288AbWE3ObT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 10:31:19 -0400
Date: Tue, 30 May 2006 07:24:20 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: perfmon@napali.hpl.hp.com
Cc: linux-ia64@vger.kernel.org, oprofile-list@lists.sourceforge.net,
       perfctr-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: 2.6.17-rc5 new perfmon code base available
Message-ID: <20060530142420.GH25544@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have released another version of the perfmon new code base package.

The patch includes:
	- update to 2.6.17-rc5
	- re-enable debugging
	- fix broken pfm_read(). Sampling was not functional.
	 (broken by the perfmon_kapi.c code)

This patch works with existing libpfm-3.2-060522 release.

You can grab the new package at our web site:

	 http://perfmon2.sf.net

-- 
-Stephane
-- 

-Stephane
