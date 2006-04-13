Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWDMD1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWDMD1i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 23:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbWDMD1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 23:27:37 -0400
Received: from pat.uio.no ([129.240.10.6]:2982 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964774AbWDMD1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 23:27:37 -0400
Subject: Re: PROBLEM: NFS data corruption
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: jgmtfia Mr <jgmtfia@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <16e19f4b0604122025s310f1989j1c301dd5d90f5059@mail.gmail.com>
References: <16e19f4b0604122025s310f1989j1c301dd5d90f5059@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 12 Apr 2006 23:27:27 -0400
Message-Id: <1144898847.8056.21.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.567, required 12,
	autolearn=disabled, AWL 1.43, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-12 at 21:25 -0600, jgmtfia Mr wrote:
> When transferring from a 2.6.16 nfs client to a 2.6.16.1 server I get
> data corruption.  There is no indication of any problems in any log on
> the client or server.  It does *not* happen when transferring from
> server to client.

Do you get corruption with 2.6.17-rc1? That has a fix for a known
corruption issue.

Cheers,
  Trond

