Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbUCCDx4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 22:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbUCCDx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 22:53:56 -0500
Received: from fe3-cox.cox-internet.com ([66.76.2.40]:54702 "EHLO
	fe3.cox-internet.com") by vger.kernel.org with ESMTP
	id S262343AbUCCDxz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 22:53:55 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Billy Rose <billyrose@cox-internet.com>
To: linux-kernel@vger.kernel.org
Subject: kernel mode console
Date: Tue, 2 Mar 2004 21:52:06 -0600
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200403022152.06950.billyrose@cox-internet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have some bandwidth i can dedicate to writting a kernel module that provides 
a command interpreter running in kernel space (think of it as the god mode 
console in quake). the purpose for this would be primarily aimed at the 
kernel developers so they can reach in and grab variables, dump certain 
sections of memory, walk memory, dump code segments, dump processes 
(including the kernel data structures for them), anything else i/you can 
think of. is this a waste of time, or would that get used?

-------------------
. ~billyrose/make
