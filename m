Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVCURrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVCURrK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 12:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVCURrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 12:47:10 -0500
Received: from pat.uio.no ([129.240.130.16]:31887 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261207AbVCURrG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 12:47:06 -0500
Subject: Re: Make NFS userspace and server directories cookies independant
	[patch, fc3, 2.6.10-1.766_FC3]
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Olivier Galibert <galibert@pobox.com>
Cc: "Hack inc." <linux-kernel@vger.kernel.org>, nfs@lists.sourceforge.net
In-Reply-To: <20050321162142.GB46055@dspnet.fr.eu.org>
References: <20050321162142.GB46055@dspnet.fr.eu.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 21 Mar 2005 12:46:58 -0500
Message-Id: <1111427218.10508.27.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.746, required 12,
	autolearn=disabled, AWL 1.25, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

må den 21.03.2005 Klokka 17:21 (+0100) skreiv Olivier Galibert:

> Patch is against a fedora core 3 2.6.10, it requires minor
> modifications (context change, not contents) in the nfs_do_filldir par
> of the dir.c change to account for the dirent addition to apply to
> 2.6.11.  I can update it if useful.
> 

If you could please update it for 2.6.12-rc1, then I'll be able to queue
it up for testing and possible inclusion in 2.6.13.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

