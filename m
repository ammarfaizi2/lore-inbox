Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132685AbRAVS61>; Mon, 22 Jan 2001 13:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135209AbRAVS6R>; Mon, 22 Jan 2001 13:58:17 -0500
Received: from pat.uio.no ([129.240.130.16]:17813 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S132685AbRAVS6F>;
	Mon, 22 Jan 2001 13:58:05 -0500
To: patl@curl.com (Patrick J. LoPresti)
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [NFS] Help: 2.2.18 NFS is corrupting our files
In-Reply-To: <s5gvgr71xao.fsf@egghead.curl.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 22 Jan 2001 19:57:46 +0100
In-Reply-To: patl@curl.com's message of "22 Jan 2001 09:22:39 -0500"
Message-ID: <shsbsszqus5.fsf@charged.uio.no>
X-Mailer: Gnus v5.6.45/XEmacs 21.1 - "Channel Islands"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Patrick J LoPresti <patl@curl.com> writes:

     > This developer is now regularly seeing two problems which began
     > with the 2.2.18 upgrade.  First, remote clients occasionally
     > get "stale NFS file handle" errors for no apparent reason.
     > Second, some of the files are being corrupted.

What filesystem are you exporting?

Cheers,
  Trond
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
