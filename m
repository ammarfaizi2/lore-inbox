Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130485AbRBNTBR>; Wed, 14 Feb 2001 14:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130821AbRBNTBH>; Wed, 14 Feb 2001 14:01:07 -0500
Received: from crudelia.cli.di.unipi.it ([131.114.11.37]:5894 "EHLO
	mailserver.cli.di.unipi.it") by vger.kernel.org with ESMTP
	id <S130485AbRBNTAy>; Wed, 14 Feb 2001 14:00:54 -0500
Organization: Centro di Calcolo - Dipartimento di Informatica di Pisa - Italy
Received: from delta19.cli.di.unipi.it(131.114.11.189)
 via SMTP by vger.kernel.org, id smtpda20047; Wed Feb 14 19:59:05 2001
Date: Mon, 12 Feb 2001 08:10:01 +0100 (CET)
From: Elena Labruna <labruna@cli.di.unipi.it>
To: linux-kernel@vger.kernel.org
Subject: longjmp problem
Message-ID: <Pine.LNX.4.21.0102120802270.3423-100000@delta19.cli.di.unipi.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working with a C package written by other
on a linux machine with kernel version 2.2.14,
often in a calls of longjmp routine
the system crash with a SIGSEGV signal. 
 
Anyone can tell me if it can be a kernel problem ?

Elena Labruna.

