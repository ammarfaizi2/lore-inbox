Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282872AbRLLXJn>; Wed, 12 Dec 2001 18:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282874AbRLLXJ2>; Wed, 12 Dec 2001 18:09:28 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:14609 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S282872AbRLLXJO>;
	Wed, 12 Dec 2001 18:09:14 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Any arch specific changes to scripts directory?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 13 Dec 2001 10:09:03 +1100
Message-ID: <20875.1008198543@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does any architecture have local changes to the scripts directory?
This includes scripts/mkdep.c, the config code etc.  Or to the top
level Makefile and Rules.make?  I need to know about anything that
affects the overall kernel build and is not in the base kernel.

