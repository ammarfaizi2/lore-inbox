Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131408AbRDJLLM>; Tue, 10 Apr 2001 07:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131424AbRDJLLD>; Tue, 10 Apr 2001 07:11:03 -0400
Received: from uucp.nl.uu.net ([193.79.237.146]:29875 "EHLO uucp.nl.uu.net")
	by vger.kernel.org with ESMTP id <S131408AbRDJLKv>;
	Tue, 10 Apr 2001 07:10:51 -0400
Date: Tue, 10 Apr 2001 12:55:29 +0200 (CEST)
From: kees <kees@schoen.nl>
To: linux-kernel@vger.kernel.org
Subject: [RFC] exec_via_sudo
Message-ID: <Pine.LNX.4.21.0104101251210.6726-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Unix/Linux have a lot of daemons that have to run as root because they
need to acces some specific data or run special programs. They are
vulnerable as we learn.
Is there any way to have something like an exec call that is
subject to a sudo like permission system? That would run the daemons
as a normal user but allow only for specific functions i.e. NOT A SHELL.
comments?

Kees

