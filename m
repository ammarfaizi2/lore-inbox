Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbUBXPqb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 10:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbUBXPqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 10:46:31 -0500
Received: from main.gmane.org ([80.91.224.249]:54731 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262285AbUBXPq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 10:46:29 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Why are 2.6 modules so huge?
Date: Tue, 24 Feb 2004 16:46:19 +0100
Message-ID: <yw1x1xokcwfo.fsf@kth.se>
References: <9cfptc4lckg.fsf@rogue.ncsl.nist.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 217.28.33.247
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:ndEQHvHjEBkCCKmhejSAd2V5hFU=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Soboroff <ian.soboroff@nist.gov> writes:

> Can anyone help me understand why 2.6-series kernel modules are so
> huge?
>
> 2.6.3/kernel/fs/vfat:
> total 288
> -rw-r--r--    1 root     root       289086 Feb 24 10:09 vfat.ko

My 2.6.3 vfat.ko is 15365 bytes.  Maybe you enabled kernel debugging
symbols.

-- 
Måns Rullgård
mru@kth.se

