Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVFSM54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVFSM54 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 08:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVFSM54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 08:57:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:65183 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261836AbVFSM5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 08:57:54 -0400
X-Authenticated: #15573369
Date: Sun, 19 Jun 2005 14:55:37 +0200
From: Michael Gollnick <Mollnick@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: How to map the Linux exception vectors to any address
Message-ID: <20050619145537.66b889fa@veritaz.laptop>
Organization: home
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-portbld-freebsd4.10)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I am pretty new to the list and I've already searched the FAQ but I
didn't find a hint how to do it.

I want to map the Linux ARM exception vectors to any specific address
and I want to know whether it is enough to modify vectors_base() in
include/asm_arm.h to achieve this or if there are more contraints I
don't know.
I know that this is not the ARM mailing list but it is more a general
question.

Would be nice if anybody could tell me which files I have to modify
to do this.

Thanks in advance!

Michael Gollnick
