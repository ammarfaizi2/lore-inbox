Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbUDLA1Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 20:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbUDLA1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 20:27:25 -0400
Received: from tungsten.bulletproof.net.au ([203.222.130.34]:18668 "EHLO
	tungsten.bulletproof.net.au") by vger.kernel.org with ESMTP
	id S262541AbUDLA1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 20:27:24 -0400
To: linux-kernel@vger.kernel.org
Subject: v2.6.5:  i386 arch depends on x86_64
Message-ID: <1081729641.4079e269d08aa@webmail.bulletproof.it>
Date: Mon, 12 Apr 2004 10:27:21 +1000 (EST)
From: Jon Tidswell <firstname@lastname.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.6
X-Originating-IP: 202.172.121.111
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i386 earlyprintk.c #includes x86_64 earlyprintk.c as its implementation

based on the principle of least surprise I would expect to be able to
build the i386 arch without the x86_64 arch present but not vice versa


Jon Tidswell                                         <firstname@lastname.org>
Disclaimer: I think my thoughts are my own, and I believe my writings are too.
