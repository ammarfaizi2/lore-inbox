Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263308AbUC3A5X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 19:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263334AbUC3A5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 19:57:23 -0500
Received: from dh132.citi.umich.edu ([141.211.133.132]:63363 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S263308AbUC3A5Q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 19:57:16 -0500
Subject: Re: nfs errors with xfs filesystem (2.4.x kernel)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "F. Baker" <baker@deslab.mit.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200403292051.i2TKp9dd027008@deslab.mit.edu>
References: <200403292051.i2TKp9dd027008@deslab.mit.edu>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1080608244.2410.295.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Mar 2004 19:57:24 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 29/03/2004 klokka 15:51, skreiv F. Baker:

> PS: Interestingly:
> 
> 	cp file1 file2
> where file1 is sufficiently large (1 MB or bigger) always fails the 
> first time, but often does a partial write.  
> 
> If you then delete file2 and try the command anew, it works fine.
> Very strange indeed.

Have you read the FAQ entry on http://nfs.sourceforge.net/#faq_e4

Cheers,
  Trond
