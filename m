Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbUKBVj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbUKBVj2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 16:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbUKBVjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 16:39:13 -0500
Received: from pat.uio.no ([129.240.130.16]:27342 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262214AbUKBViW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 16:38:22 -0500
Subject: Re: nfs stale filehandle issues with 2.6.10-rc1 in-kernel server
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Jeff V. Merkey" <jmerkey@drdos.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Brad Campbell <brad@wasp.net.au>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4187F69E.9020604@drdos.com>
References: <41877751.502@wasp.net.au>
	 <1099413424.7582.5.camel@lade.trondhjem.org> <4187E4E1.5080304@pobox.com>
	 <4187F69E.9020604@drdos.com>
Content-Type: text/plain
Date: Tue, 02 Nov 2004 13:37:57 -0800
Message-Id: <1099431477.7854.21.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0.326, required 12,
	RCVD_NUMERIC_HELO 0.33)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 02.11.2004 Klokka 14:05 (-0700) skreiv Jeff V. Merkey:
> >
> I am seeing severe nfs problems between kernels again, 2.4 - > 2.6 -> 
> 2.4 V3 and V4 problems connecting and filesize mismatches between
> actual/reported. Might point to where the bug is.

Nope. I'm not seeing that at all (besides, that is entirely unrelated to
ESTALE errors).

Mind telling us how to reproduce the problem?

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

