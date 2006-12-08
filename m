Return-Path: <linux-kernel-owner+w=401wt.eu-S1425517AbWLHOQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425517AbWLHOQK (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 09:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760742AbWLHOQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 09:16:10 -0500
Received: from zombie.ncsc.mil ([144.51.88.131]:48905 "EHLO jazzdrum.ncsc.mil"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760739AbWLHOQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 09:16:08 -0500
Subject: Re: -mm merge plans for 2.6.20
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061204204024.2401148d.akpm@osdl.org>
References: <20061204204024.2401148d.akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 08 Dec 2006 09:09:34 -0500
Message-Id: <1165586974.12263.190.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-04 at 20:40 -0800, Andrew Morton wrote:
> mprotect-patch-for-use-by-slim.patch
> integrity-service-api-and-dummy-provider.patch
> integrity-service-api-and-dummy-provider-cleanup-use-of-configh.patch
> integrity-service-api-and-dummy-provider-compilation-warning-fix.patch
> slim-main-patch.patch
> slim-main-patch-socket_post_create-hook-return-code.patch
> slim-main-patch-misc-cleanups-requested-at-inclusion-time.patch
> slim-main-patch-handle-failure-to-register.patch
> slim-main-patch-fix-bug-with-mm_users-usage.patch
> slim-main-patch-security-slim-slm_mainc-make-2-functions-static.patch
> slim-secfs-patch.patch
> slim-secfs-patch-slim-correct-use-of-snprintf.patch
> slim-secfs-patch-cleanup-use-of-configh.patch
> slim-make-and-config-stuff.patch
> slim-make-and-config-stuff-makefile-fix.patch
> slim-debug-output.patch
> slim-fix-security-issue-with-the-task_post_setuid-hook.patch
> slim-secfs-inode-i_private-build-fix.patch
> slim-documentation.patch
> fdtable-make-fdarray-and-fdsets-equal-in-size-slim.patch
> 
>  Shall hold in -mm.

Why?  I haven't seen any evidence that prior review comments have been
addressed so far, and a fresh patch set would be beneficial anyway to
facilitate full review of the updated code and to allow them to fix
their patch descriptions as well (as they were wrong in some instances,
describing older versions of the code).

-- 
Stephen Smalley
National Security Agency

