Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264314AbTCXTZC>; Mon, 24 Mar 2003 14:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264365AbTCXTZC>; Mon, 24 Mar 2003 14:25:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54027 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264314AbTCXTZB>; Mon, 24 Mar 2003 14:25:01 -0500
Message-ID: <3E7F5E1F.2080802@zytor.com>
Date: Mon, 24 Mar 2003 11:35:59 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en, sv
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: ftp://ftp.kernel.org/pub/scm/
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have set up a tree on kernel.org for SCM repositories.  Currently it
contains a mirror of the bk->cvs repository tree at:

ftp://ftp.kernel.org/pub/scm/linux/kernel/bkcvs/

The main intent for this is to make it possible to rsync the full
repository; we currently don't have CVS pserver access or anything like
that (maybe later.)

This tree is mirrored hourly from kernel.bkbits.net.

I'm hoping someone with a BK license and a kernel.org account could add
the bk exports file to this tree, as well.

	-hpa

