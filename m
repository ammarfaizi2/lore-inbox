Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267771AbTGLGmG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 02:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267773AbTGLGmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 02:42:06 -0400
Received: from pat.uio.no ([129.240.130.16]:30350 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S267771AbTGLGmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 02:42:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16143.44997.454727.455795@charged.uio.no>
Date: Sat, 12 Jul 2003 08:50:45 +0200
To: Christoph Hellwig <hch@infradead.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre5
In-Reply-To: <20030712072713.A1219@infradead.org>
References: <Pine.LNX.4.55L.0307111705090.5422@freak.distro.conectiva>
	<shsu19siyru.fsf@charged.uio.no>
	<Pine.LNX.4.55L.0307111752060.5537@freak.distro.conectiva>
	<16143.10146.718830.585351@charged.uio.no>
	<Pine.LNX.4.55L.0307111853540.5883@freak.distro.conectiva>
	<20030712072713.A1219@infradead.org>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Christoph Hellwig <hch@infradead.org> writes:

     > Patch looks fine.  I don't really like the directfileio name,

Feel free to suggest a better one. I chose it 'cos I hate the idea of
version numbers on function names (i.e. direct_iO2).

     > but hey, this cludge is so ugly that it doesn't really matter
     > anymore..

Agreed...

cheers,
  Trond
