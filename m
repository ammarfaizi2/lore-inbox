Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUAOUQR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 15:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbUAOUQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 15:16:17 -0500
Received: from dh197.citi.umich.edu ([141.211.133.197]:9600 "EHLO
	nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S261875AbUAOUQQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 15:16:16 -0500
Subject: Re: Slowwwwwwwwwwww NFS read performance....
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1074196422.2907.35.camel@dyn319250.beaverton.ibm.com>
References: <Pine.LNX.4.44.0401060055570.1417-100000@poirot.grange>
	 <200401130155.32894.hackeron@dsl.pipex.com>
	 <1074025508.1987.10.camel@lumiere>
	 <1074026758.4524.65.camel@nidelv.trondhjem.org>
	 <bu4pd6$anf$1@news.cistron.nl>
	 <1074134135.1522.52.camel@nidelv.trondhjem.org>
	 <1074193256.2148.55.camel@nidelv.trondhjem.org>
	 <1074196422.2907.35.camel@dyn319250.beaverton.ibm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1074197762.1232.1.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 15 Jan 2004 15:16:02 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På to , 15/01/2004 klokka 14:53, skreiv Ram Pai:
> Yes this problem has been reported earlier. Attaching Andrew's patch
> that reverts a change. This should work. Please confirm.

Sorry to disappoint you, but that change appears already in 2.6.1-mm3,
and does not suffice to fix the problem.

Cheers,
  Trond
