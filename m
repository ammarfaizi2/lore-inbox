Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317362AbSGIQdM>; Tue, 9 Jul 2002 12:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317361AbSGIQdM>; Tue, 9 Jul 2002 12:33:12 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1043 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317360AbSGIQdD>; Tue, 9 Jul 2002 12:33:03 -0400
Subject: Re: Linux 2.4.19-rc1-ac1
To: jmacbaine@yahoo.de (=?iso-8859-1?q?Jim=20MacBaine?=)
Date: Tue, 9 Jul 2002 17:59:00 +0100 (BST)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020709163002.11174.qmail@web40101.mail.yahoo.com> from "=?iso-8859-1?q?Jim=20MacBaine?=" at Jul 09, 2002 06:30:01 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17RyKL-0005GU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it safe to compile with GCC 3.1 (or 3.1.1pre)?

Not always. 586 seems to have real problems.
