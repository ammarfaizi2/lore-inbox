Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262952AbVCDT4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262952AbVCDT4n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 14:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbVCDTsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 14:48:55 -0500
Received: from pat2.uio.no ([129.240.130.19]:22171 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263009AbVCDTgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 14:36:49 -0500
Subject: Re: nothing in /proc/fs/nfs/exports ?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1109937510l.11030l.0l@werewolf.able.es>
References: <1109937510l.11030l.0l@werewolf.able.es>
Content-Type: text/plain
Date: Fri, 04 Mar 2005 11:36:39 -0800
Message-Id: <1109964999.10173.24.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.45, required 12,
	autolearn=disabled, AWL 1.55, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fr den 04.03.2005 Klokka 11:58 (+0000) skreiv J.A. Magallon:

> ===== /proc/fs/nfs/exports
> # Version 1.1
> # Path Client(Flags) # IPs
> 
> Nothing in xtab ? Nothing in /proc ? Why ?
> 

"man exportfs". Read all about the 2.6 kernel's new mechanism for
communication between mountd and the kernel.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

