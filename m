Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262462AbUK3Xna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbUK3Xna (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbUK3XmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 18:42:16 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.21]:58411 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S262437AbUK3Xjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 18:39:46 -0500
Subject: kernel signatures
From: Harm Verhagen <h.verhagen.web103@dse.nl>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1101858008.4534.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 01 Dec 2004 00:40:08 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I use the signatures on the kernel releases to verify all files that I
download. 
But..... whats with the following  files ?
patch-2.6.X.sign 
linux-2.6.X.sign
What do they sign ?

I _do_ understand the following types:

patch-2.6.X.tar.gz.sign is the signature of:
patch-2.6.X.tar.gz

patch.2.6.X.tar.bz2.sign is the signature of:
patch.2.6.X.tar.bz2

I suspect this is some kind of FAQ but I couldn't find it.

Regards,
Harm

