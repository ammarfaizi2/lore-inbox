Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVBMRtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVBMRtk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 12:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVBMRtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 12:49:40 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:19475 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261288AbVBMRtj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 12:49:39 -0500
Message-Id: <200502131935.j1DJZYnW003002@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
cc: Vadim Abrossimov <vadim_abrossimov@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uml: support a separate build tree; support USER_OBJS dependencies 
In-Reply-To: Your message of "Sun, 13 Feb 2005 16:46:52 GMT."
             <20050213164652.GE8859@parcelfarce.linux.theplanet.co.uk> 
References: <opsl43d9yilfdzum@localhost.localdomain> <200502131813.j1DICsnW002251@ccure.user-mode-linux.org>  <20050213164652.GE8859@parcelfarce.linux.theplanet.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 13 Feb 2005 14:35:34 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk said:
> Err...  FWIW, aforementioned patch lacks e.g. vmlinux.lds.S.

Yeah, I have that fixed locally.  I just haven't pushed out the new stuff yet.

				Jeff


