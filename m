Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbUKHDmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbUKHDmU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 22:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbUKHDmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 22:42:20 -0500
Received: from pat.uio.no ([129.240.130.16]:24977 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261740AbUKHDmR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 22:42:17 -0500
Subject: Re: [BUG] Nfs 3 ops
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Pedro Larroy <piotr@larroy.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041108022839.GA2560@larroy.com>
References: <20041108022839.GA2560@larroy.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sun, 07 Nov 2004 19:41:58 -0800
Message-Id: <1099885318.7922.0.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0.326, required 12,
	RCVD_NUMERIC_HELO 0.33)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

må den 08.11.2004 Klokka 03:28 (+0100) skreiv Pedro Larroy:
> Hi
> 
> Here comes a little ops I got while accessing a remote nfs dir in 2.6.8
> on i386 SMP

...and that Oops is precisely why we put out 2.6.8.1

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

