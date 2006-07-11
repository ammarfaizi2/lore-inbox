Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbWGKDEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbWGKDEi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 23:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbWGKDEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 23:04:38 -0400
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:45983 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964974AbWGKDEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 23:04:37 -0400
Date: Mon, 10 Jul 2006 22:58:50 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.18-rc1-mm1
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <200607102302_MC3-1-C4A4-1385@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jul 2006 02:11:06 -0700, Andrew morton wrote:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/

Warnings(?) during build:

/home/me/linux/2.6.18-rc1-mm1-64/scripts/Kbuild.klibc:315: target `usr/kinit/ipconfig' given more than once in the same rule.
/home/me/linux/2.6.18-rc1-mm1-64/scripts/Kbuild.klibc:315: target `usr/kinit/nfsmount' given more than once in the same rule.
/home/me/linux/2.6.18-rc1-mm1-64/scripts/Kbuild.klibc:315: target `usr/kinit/run-init' given more than once in the same rule.
/home/me/linux/2.6.18-rc1-mm1-64/scripts/Kbuild.klibc:315: target `usr/kinit/fstype' given more than once in the same rule.

-- 
Chuck
