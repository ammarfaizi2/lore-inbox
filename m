Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265574AbTGKUzd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265421AbTGKUzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:55:33 -0400
Received: from pat.uio.no ([129.240.130.16]:10942 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S265574AbTGKUz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 16:55:28 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16143.10146.718830.585351@charged.uio.no>
Date: Fri, 11 Jul 2003 23:09:54 +0200
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre5
In-Reply-To: <Pine.LNX.4.55L.0307111752060.5537@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307111705090.5422@freak.distro.conectiva>
	<shsu19siyru.fsf@charged.uio.no>
	<Pine.LNX.4.55L.0307111752060.5537@freak.distro.conectiva>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Marcelo Tosatti <marcelo@conectiva.com.br> writes:

    >> Is there still any chance for the NFS O_DIRECT support to make
    >> it?

     > I guess the best way of doing so would be adding ->direct_io2
     > and KERNEL24_HAS_ODIRECT_2 define.

That is what the last patch I sent you does (also sent to l-k). Should
I resend?

Cheers,
  Trond
