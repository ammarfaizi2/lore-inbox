Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbUKCXjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbUKCXjh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 18:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUKCXfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 18:35:38 -0500
Received: from pat.uio.no ([129.240.130.16]:37263 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262002AbUKCXdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 18:33:12 -0500
Subject: Re: nfs stale filehandle issues with 2.6.10-rc1 in-kernel server
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Jeff V. Merkey" <jmerkey@drdos.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Brad Campbell <brad@wasp.net.au>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <41894FC0.6080609@drdos.com>
References: <41877751.502@wasp.net.au>
	 <1099413424.7582.5.camel@lade.trondhjem.org> <4187E4E1.5080304@pobox.com>
	 <4187F69E.9020604@drdos.com> <1099431477.7854.21.camel@lade.trondhjem.org>
	 <20041102225304.GA11441@galt.devicelogics.com> <41882414.2070003@drdos.com>
	 <1099444402.9957.8.camel@lade.trondhjem.org> <41890D5F.4000006@drdos.com>
	  <41894FC0.6080609@drdos.com>
Content-Type: text/plain
Date: Wed, 03 Nov 2004 15:32:48 -0800
Message-Id: <1099524768.16898.18.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0.326, required 12,
	RCVD_NUMERIC_HELO 0.33)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 03.11.2004 Klokka 14:38 (-0700) skreiv Jeff V. Merkey:
> I personally think this is a broken behavior, but perhaps it's in line 
> with some NFS
> spec somewhere.  I have coded around it, but thout I would mention it to
> you.

This should already be fixed in 2.6.x kernels.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

