Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWBBUCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWBBUCl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 15:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWBBUCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 15:02:41 -0500
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:58044 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751133AbWBBUCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 15:02:41 -0500
Date: Thu, 2 Feb 2006 15:00:18 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Wanted: hotfixes for -mm kernels
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200602021502_MC3-1-B772-547@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most -mm kernels have small but critical bugs that are found shortly
after release.  Patches for these are posted on linux-kernel but
they aren't made available on kernel.org until the next -mm release.

Would it be possible to create a hotfix/ directory for each -mm
release and put those patches there?  A README could explain that
the fixes are untested.  At least people reading the files could
see an issue exists even if they're not brave enough to try the
patch. :)

-- 
Chuck

