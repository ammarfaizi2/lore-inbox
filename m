Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262783AbVDAQeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262783AbVDAQeL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 11:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbVDAQeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 11:34:11 -0500
Received: from pat.uio.no ([129.240.130.16]:63397 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262783AbVDAQeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 11:34:08 -0500
Subject: Re: NFS client latencies
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Orion Poplawski <orion@cora.nwra.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d2js2h$v74$1@sea.gmane.org>
References: <20050331065942.GA14952@elte.hu>
	 <20050330231801.129b0715.akpm@osdl.org> <20050331073017.GA16577@elte.hu>
	 <1112270304.10975.41.camel@lade.trondhjem.org>
	 <1112272451.10975.72.camel@lade.trondhjem.org>
	 <20050331135825.GA2214@elte.hu>
	 <1112279522.20211.8.camel@lade.trondhjem.org>
	 <20050331143930.GA4032@elte.hu> <20050331145015.GA4830@elte.hu>
	 <1112322516.2509.28.camel@mindpipe> <20050401043022.GA22753@elte.hu>
	 <d2js2h$v74$1@sea.gmane.org>
Content-Type: text/plain
Date: Fri, 01 Apr 2005 11:33:51 -0500
Message-Id: <1112373231.1009.5.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.42, required 12,
	autolearn=disabled, AWL 1.53, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fr den 01.04.2005 Klokka 09:16 (-0700) skreiv Orion Poplawski:
> Just a question - would these changes be expected to improve NFS client 
> *read* access at all, or just write?

Just write.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

