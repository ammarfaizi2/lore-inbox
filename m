Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283697AbRLWFXN>; Sun, 23 Dec 2001 00:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283658AbRLWFXD>; Sun, 23 Dec 2001 00:23:03 -0500
Received: from clink.CS.NMSU.Edu ([128.123.64.152]:45499 "EHLO
	clink.cs.nmsu.edu") by vger.kernel.org with ESMTP
	id <S283697AbRLWFWt>; Sun, 23 Dec 2001 00:22:49 -0500
Date: Sat, 22 Dec 2001 22:22:48 -0700 (MST)
From: Ciju John <cjohn@cs.nmsu.edu>
To: <linux-kernel@vger.kernel.org>
Subject: connect refused reasons
Message-ID: <Pine.LNX.4.30.0112222213140.3467-100000@clink>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
	I am using kernel 2.2.14-5.0smp. I keep getting " Connection
refused" on repeated 'sendto' calls.
	Am I correct in saying that the only reason for this error is
'non-availability of ports'. I have tested for data being sent to
non-listening ports, but cannot reproduce the error. Any help would be
greatly appreciated.
						sincerely,
						Ciju

