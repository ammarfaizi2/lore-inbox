Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271823AbTG2Ody (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 10:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271824AbTG2Ody
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 10:33:54 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:52617
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S271823AbTG2Odw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 10:33:52 -0400
Date: Tue, 29 Jul 2003 10:49:40 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 NFS file transfer
Message-ID: <20030729104940.A12949@animx.eu.org>
References: <20030728225947.GA1694@localhost.localdomain> <20030729072440.A12426@animx.eu.org> <20030729130400.GA4052@localhost.localdomain> <20030729094428.B12763@animx.eu.org> <shsfzkpxw95.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <shsfzkpxw95.fsf@charged.uio.no>; from Trond Myklebust on Tue, Jul 29, 2003 at 04:06:46PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>      > On a side note, I wish I could export / to whoever and
>      > everything seen on the localsystem under / is exported just
>      > like the userspace daemon.
> 
> Your homework assignment for tomorrow:
> 
>     'man 5 exports'
> 
> In particular read up on 'nohide'

I've done this.  I have to export every possible mountpoint still on the
server and have to export that for each individual ip.  I tried mounting a
server setup like that with client 2.6.0-test1 and nohide does not work. 
with a 2.4.20 client, it does.  server kernel 2.4.20 nfsd 1.0.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
