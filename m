Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTFDTK2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 15:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbTFDTK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 15:10:28 -0400
Received: from spanner.eng.cam.ac.uk ([129.169.8.9]:50160 "EHLO
	spanner.eng.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263894AbTFDTJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 15:09:54 -0400
Date: Wed, 4 Jun 2003 20:23:21 +0100 (BST)
From: "P. Benie" <pjb1008@eng.cam.ac.uk>
To: Hua Zhong <hzhong@cisco.com>
cc: "'Linus Torvalds'" <torvalds@transmeta.com>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] [2.5] Non-blocking write can block
In-Reply-To: <Pine.HPX.4.33L.0306041946380.18475-100000@punch.eng.cam.ac.uk>
Message-ID: <Pine.HPX.4.33L.0306042022150.18475-100000@punch.eng.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jun 2003, P. Benie wrote:

> On Wed, 4 Jun 2003, Hua Zhong wrote:
> > This particular patch is in 2.4.20 already. There is another patch in
> > 2.4.20 (?) which seems to fix the "main problem" (the n_tty_write_wakeup
> > function in n_tty.c), but I didn't verify it.
>
> Yes - that's because I submitted the patch ages ago.  All that means is
> that the distributions are relying on it, not that the patch is correct!

Sorry Hua, I wasn't reading your mail correctly. Please ignore the above
comment.

Peter

