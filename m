Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbVAOInT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbVAOInT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 03:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbVAOInT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 03:43:19 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:56464 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262146AbVAOInR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 03:43:17 -0500
To: int2str@gmail.com
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <7f800d9f050114144859c46b4b@mail.gmail.com> (message from Andre
	Eisenbach on Fri, 14 Jan 2005 14:48:44 -0800)
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org> <7f800d9f050114144859c46b4b@mail.gmail.com>
Message-Id: <E1CpjWI-000468-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 15 Jan 2005 09:42:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some things I'd like to see (as I am currently using the KIO
equivalent) implemented as FUSE fs:
- "fish", virtual file access over ssh

This is already available here: 

  http://sourceforge.net/projects/fuse

You need to dowload fuse-2.2-pre3 and sshfs-1.0.  It should work on
any kernel including the 2.6.10-rc1-mm1 with FUSE compiled in.

Miklos
