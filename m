Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbUL3LcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbUL3LcP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 06:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbUL3LcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 06:32:15 -0500
Received: from pat.uio.no ([129.240.130.16]:58350 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261619AbUL3LcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 06:32:12 -0500
Subject: Re: POSIX ACL's with NFS
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andre Tomt <andre@tomt.net>
Cc: =?ISO-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>,
       Bill Davidsen <davidsen@tmr.com>, Diego <foxdemon@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
In-Reply-To: <41D3DBA1.3020800@tomt.net>
References: <d5a95e6d04122712148459507@mail.gmail.com>
	 <41D368F7.8090502@tmr.com> <20041230041013.GB9288@ime.usp.br>
	 <41D3DBA1.3020800@tomt.net>
Content-Type: text/plain
Date: Thu, 30 Dec 2004 12:30:28 +0100
Message-Id: <1104406228.12919.11.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 30.12.2004 Klokka 11:42 (+0100) skreiv Andre Tomt:

> It got submitted for inclusion on LKML some time ago, and got a few 
> kinks ironed out in that process. Not sure why it hasn't been included yet..

Those patches will remain unmergeable as long as they contain no support
whatsoever for client side caching of ACLs.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

