Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbUCWMV7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 07:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262518AbUCWMV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 07:21:59 -0500
Received: from mailhost.cs.auc.dk ([130.225.194.6]:22953 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S262513AbUCWMV5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 07:21:57 -0500
Date: Tue, 23 Mar 2004 13:21:48 +0100 (CET)
From: Soeren Noehr Christensen <snc@cs.auc.dk>
To: linux-kernel@vger.kernel.org
Subject: Kernel debugging via serialline.
Message-ID: <Pine.LNX.4.56.0403231313310.25943@homer.cs.auc.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I'm trying to debug my kernel using a serialline to another machine. I'm
am interested in getting all of the bootoutput to the other machine. I
have activated the CONFIG_SERIAL_8250_CONSOLE option in the tested
kernel, which is run with the option console=/dev/ttyS0,96008n. I'm using
minicom on the other machine, but nothing is shown in minicom. I have also
tried to cat /dev/ttyS0 on the other machine while booting the test
machine, still nothing.

Any suggestions? Is this at all possible?

Søren Nøhr Christensen
Department of Computer Science
Aalborg University

