Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265081AbSJWRCU>; Wed, 23 Oct 2002 13:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265094AbSJWRCT>; Wed, 23 Oct 2002 13:02:19 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:54242 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S265081AbSJWRCT> convert rfc822-to-8bit; Wed, 23 Oct 2002 13:02:19 -0400
Message-ID: <3DA24B2900A49061@mel-rta9.wanadoo.fr> (added by
	    postmaster@wanadoo.fr)
Date: Wed, 23 Oct 2002 19:08:23 +0200 (MET DST)
From: "Florian FERNANDEZ" <Florian.Fernandez2@wanadoo.fr>
To: <linux-kernel@vger.kernel.org>
Subject: GCC 3.3 AND KERNEL  (all versions)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When I want to compile the kernel with gcc 3.3 but there is a lot of error during the "make bzImage":

"comparison between signed and unsigned"... then crash.

I tried with linux-2.4.18, linux-2.4.19 and linux-2.4.20-pre11 and I got the same things.

All are ok when I compile with gcc 3.2.

Anyone can help me or have the same problem or compile kernel with gcc 3. 3 without error ? [ :) ]

Thanks.


