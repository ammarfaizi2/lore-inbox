Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264886AbSK0Wc2>; Wed, 27 Nov 2002 17:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264888AbSK0Wc2>; Wed, 27 Nov 2002 17:32:28 -0500
Received: from mons.uio.no ([129.240.130.14]:20617 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S264886AbSK0Wc1> convert rfc822-to-8bit;
	Wed, 27 Nov 2002 17:32:27 -0500
To: Rasmus =?iso-8859-1?q?B=F8g?= Hansen <moffe@amagerkollegiet.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PROBLEM] NFS trouble - file corruptions
References: <Pine.LNX.4.44.0211272227220.1578-100000@grignard.amagerkollegiet.dk>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 27 Nov 2002 23:39:42 +0100
In-Reply-To: <Pine.LNX.4.44.0211272227220.1578-100000@grignard.amagerkollegiet.dk>
Message-ID: <shsptsq4oy9.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Rasmus Bøg Hansen <moffe@amagerkollegiet.dk> writes:

     > [1.] One line summary of the problem: Files created with
     > bzip2/gzip directly to NFS file system gets corrupted

Can you reproduce with 2.4.20-pre4?

(Note: the pre-patches can be found on your local ftp.dk.kernel.org in
the /pub/linux/kernel/v2.4/testing directory)

Cheers,
  Trond
