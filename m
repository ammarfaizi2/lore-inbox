Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbUCWJlA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 04:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUCWJlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 04:41:00 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:46603 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262400AbUCWJk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 04:40:58 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.5-rc2-mm1] objrmap & anon_vma from 2.6.5-rc2-aa1
Date: Tue, 23 Mar 2004 10:29:48 +0100
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
X-Operating-System: Linux 2.6.4-wolk2.1 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200403231029.48376@WOLK>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

at the location (1) you may find objrmap and anon_vma from latest -AA tree 
ontop of 2.6.5-rc2-mm1. I am not sure that all is right merged, but maybe I 
did it okay. Please review, please test :)

I am running this currently.


1. http://www.kernel.org/pub/linux/kernel/people/mcp/2.6-mm/

ciao, Marc
