Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319292AbSHVD2t>; Wed, 21 Aug 2002 23:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319293AbSHVD2t>; Wed, 21 Aug 2002 23:28:49 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:44044 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S319292AbSHVD2s>; Wed, 21 Aug 2002 23:28:48 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Problem with random.c and PPC
Date: 22 Aug 2002 03:16:32 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <ak1l2g$drl$1@abraham.cs.berkeley.edu>
References: <20020817072310.GQ5418@waste.org> <Pine.LNX.4.44.0208191034390.26653-100000@Megathlon.ESI>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1029986192 14197 128.32.153.211 (22 Aug 2002 03:16:32 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 22 Aug 2002 03:16:32 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Colombo  wrote:
>I'd say that /dev/urandom interface is somewhat broken: [...]

Also, the naming scheme is sub-optimal: it encourages
people to use /dev/random as the default, when /dev/random
should really be the exception rather than the norm.
