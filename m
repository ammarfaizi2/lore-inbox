Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbUE3AaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUE3AaW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 20:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUE3AaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 20:30:22 -0400
Received: from hera.kernel.org ([63.209.29.2]:36225 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261396AbUE3AaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 20:30:19 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: ftp.kernel.org
Date: Sun, 30 May 2004 00:29:07 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c9b9sj$ccc$1@terminus.zytor.com>
References: <Pine.GSO.4.33.0405280018250.14297-100000@sweetums.bluetronic.net> <20040528150119.GE18449@thunk.org> <20040528163234.GV2603@schnapps.adilger.int> <168FA640-B185-11D8-9291-000A958E35DC@fhm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1085876947 12685 127.0.0.1 (30 May 2004 00:29:07 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sun, 30 May 2004 00:29:07 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <168FA640-B185-11D8-9291-000A958E35DC@fhm.edu>
By author:    Daniel Egger <degger@fhm.edu>
In newsgroup: linux.dev.kernel
> 
> Actually I think this is *the* idea. Why not simply set up a
> bittorrent tracker and have a distributed kernel.org
> fileserving system? Instead of having links to http and ftp
> sites there could be a torrent link as well. Several
> OpenSource projects started distributing files with BT
> already and it seems to work like a charm.
> 

Because doing it with BitTorrent is a nightmare.  I posted a long list
of the problems with BT for doing this to the BT mailing list and
pretty much got told that there is no way to do what I'd want to do
within BT.

Some of the people from the BT list have approached me about creating
a new protocol - working name "Software Distribution Protocol"
(SDP)... but it's a big job.

	-hpa
