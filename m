Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284180AbSBZWtN>; Tue, 26 Feb 2002 17:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285720AbSBZWsf>; Tue, 26 Feb 2002 17:48:35 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:37386 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S284180AbSBZWr4>; Tue, 26 Feb 2002 17:47:56 -0500
To: linux-kernel@vger.kernel.org
From: Jonathan Hudson <jonathan@daria.co.uk>
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
x-no-productlinks: yes
Subject: tmpfs file permissions in 2.4.19-pre1-ac1
X-Newsgroups: fa.linux.kernel
Content-Type: text/plain; charset=iso-8859-1
NNTP-Posting-Host: daria.co.uk
Message-ID: <2d40.3c7c1089.64a4b@trespassersw.daria.co.uk>
Date: Tue, 26 Feb 2002 22:47:37 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed some strangeness with (at least) file permissions on a
tmpfs file system. I can't change the permissions of files I own (or,
as root, of any file) on the tmpfs.

This problem does not occur with  2.4.19pre1 or 2.4.18-rc2-ac2 (which
I can test easily).

