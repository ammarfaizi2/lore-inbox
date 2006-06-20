Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWFTFR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWFTFR2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 01:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWFTFR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 01:17:28 -0400
Received: from hera.kernel.org ([140.211.167.34]:2738 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751241AbWFTFR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 01:17:27 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: How to get kernel source release from git tree?
Date: Mon, 19 Jun 2006 22:17:22 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e780d2$br9$1@terminus.zytor.com>
References: <4497830B.5010402@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1150780642 12138 127.0.0.1 (20 Jun 2006 05:17:22 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 20 Jun 2006 05:17:22 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <4497830B.5010402@163.com>
By author:    Walkinair <walktodeath@163.com>
In newsgroup: linux.dev.kernel
>
> Hi, this may be a stupid question, sorry for this.
> 
> I have kenel 2.6 git tree in my local box, usually through the following 
> steps I get source release,
> 1. copy git repository to a new directory.
> 2. rm .git directory.
> 3. make config; make; make modules_install; make install
> 
> I there any convinient git command or other ways to get kernel release 
> from git repository?
> 

If you have Cogito installed, use cg-export.

	-hpa
