Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262992AbTDFOun (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 10:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262993AbTDFOun (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 10:50:43 -0400
Received: from mons.uio.no ([129.240.130.14]:36307 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id S262992AbTDFOum (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 10:50:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16016.16757.380048.996214@charged.uio.no>
Date: Sun, 6 Apr 2003 17:02:13 +0200
To: Siim Vahtre <siim@pld.ttu.ee>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: nfs issues
In-Reply-To: <Pine.GSO.4.53.0304061731540.17774@pitsa.pld.ttu.ee>
References: <Pine.GSO.4.53.0304060937020.17774@pitsa.pld.ttu.ee>
	<shsfzovn5uy.fsf@charged.uio.no>
	<Pine.GSO.4.53.0304061731540.17774@pitsa.pld.ttu.ee>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Siim Vahtre <siim@pld.ttu.ee> writes:

     > Using 2.4 kernel for client is fine. (tried 2.4.21-pre7
     > aswell).  But I want to use 2.5 on the client side.. atm it
     > screws the data.

Tough. 2.5.x is a development kernel, and yes, there are still bugs
and issues to be tracked down.
If you need stability use 2.4.x

Cheers,
  Trond
