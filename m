Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280150AbRKIVVq>; Fri, 9 Nov 2001 16:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280134AbRKIVVf>; Fri, 9 Nov 2001 16:21:35 -0500
Received: from Expansa.sns.it ([192.167.206.189]:45577 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S280136AbRKIVVY>;
	Fri, 9 Nov 2001 16:21:24 -0500
Date: Fri, 9 Nov 2001 22:21:27 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: <linux-kernel@vger.kernel.org>
Subject: binfmt_misc and 2.4.13|14
Message-ID: <Pine.LNX.4.33.0111092218100.23632-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI,
Has it been noticed that loading binfmt_misc module with 2.4.13|14
kernel the procfs entries
/proc/sys/fs/binfmt_misc/register
/proc/sys/fs/binfmt_misc/status
are not created anymore?

so the directory /proc/sys/fs/binfmt_misc is emtpy, and I do not know how
to manage this module.
Some hints?

Luigi Genoni


