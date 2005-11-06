Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbVKFOw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVKFOw6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 09:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbVKFOw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 09:52:57 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:22764 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S1750832AbVKFOw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 09:52:57 -0500
Date: Sun, 6 Nov 2005 15:52:52 +0100
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: vbetool, mm kernels and mmap
Message-ID: <20051106145252.GB881@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

Playing around with suspend 2 ram I have to use vbetool.
Using kernel 2.6.14-rc4-mm1 (and probably earlier) I get:

program vbetool is using MAP_PRIVATE, PROT_WRITE mmap of VM_RESERVED
memory, which is deprecated. Please report this to linux-kernel@vger.kernel.org

Well, here I report. It is the debian package version 0.3 of vbetool.


Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining AT logic DOT at>             Università di Siena
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
LYBSTER (n., vb.)
The artificial chuckle in the voice-over at the end of a supposedly
funny television commercial.
			--- Douglas Adams, The Meaning of Liff
