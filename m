Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVCZVND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVCZVND (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 16:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVCZVND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 16:13:03 -0500
Received: from hera.kernel.org ([209.128.68.125]:41879 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261266AbVCZVNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 16:13:00 -0500
Date: Sat, 26 Mar 2005 13:28:01 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.30-rc3
Message-ID: <20050326162801.GA20729@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

Here goes -rc3.

A nasty typo happened while merging v2.6 load_elf_library() DoS fix,
which could leap to oopses.

Summary of changes from v2.4.30-rc2 to v2.4.30-rc3
============================================

Marcelo Tosatti:
  o Andreas Arens: Fix deadly mismerge of binfmt_elf DoS fix
  o Change VERSION to 2.4.30-rc3


