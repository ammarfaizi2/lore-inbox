Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264907AbTBAQOW>; Sat, 1 Feb 2003 11:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264908AbTBAQOW>; Sat, 1 Feb 2003 11:14:22 -0500
Received: from pat.uio.no ([129.240.130.16]:64506 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S264907AbTBAQOV>;
	Sat, 1 Feb 2003 11:14:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15931.62606.441404.74917@charged.uio.no>
Date: Sat, 1 Feb 2003 17:23:42 +0100
To: David Ford <david+powerix@blue-labs.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@digeo.com>
Subject: Re: NFS problems, 2.5.5x
In-Reply-To: <3E3BEFDB.3060208@blue-labs.org>
References: <3E3B2D2E.8000604@blue-labs.org>
	<15931.35891.22926.408963@charged.uio.no>
	<3E3BEFDB.3060208@blue-labs.org>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == David Ford <david+powerix@blue-labs.org> writes:

     > The last time NFS was working, I had 2.4.19 and 2.5.53 clients
     > on a
     > 2.5.59 server, that was yesterday.  I had experienced a slight
     >        problem
     > with it last week when my 2.5.53 client was booted for first
     > time on 2.5.5x, it was previously a 2.4 kernel.  The server
     > OOPSed repeatedly shortly after bootup in NFS stuff then it
     > never happened again and was rock solid until today.

So have you tried out the 2.5.53 client since you noticed this
problem?

Cheers,
  Trond
