Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275063AbTHLGNp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 02:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275067AbTHLGNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 02:13:45 -0400
Received: from magic-mail.adaptec.com ([208.236.45.100]:47845 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S275063AbTHLGNo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 02:13:44 -0400
Date: Mon, 11 Aug 2003 23:40:21 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: nagendra_tomar@adaptec.com
To: linux-kernel@vger.kernel.org
Subject: modprobe: QM_MODULES: Function not implemented ??
Message-ID: <Pine.LNX.4.44.0308112338150.1464-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to load a module in 2.6.0-test2 downloaded from kernel.org
I am getting the above error. Probably this means the kernel does not 
support query_module() interface, but why ?? With 2.4.18 things were 
absolutely fine. Is it a deprecated interface. 
Any help is welcome.

Thanx
tomar

