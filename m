Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262603AbVBCBG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbVBCBG3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 20:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbVBCBG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 20:06:28 -0500
Received: from hera.kernel.org ([209.128.68.125]:48515 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262567AbVBCBFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 20:05:12 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [2.6 patch] add compiler-gcc4.h
Date: Thu, 3 Feb 2005 01:04:46 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <ctrtbe$570$1@terminus.zytor.com>
References: <20050130130308.GK3185@stusta.de> <m1pszn3t2w.fsf@muc.de> <41FCFED4.1070301@tiscali.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1107392686 5345 127.0.0.1 (3 Feb 2005 01:04:46 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Thu, 3 Feb 2005 01:04:46 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <41FCFED4.1070301@tiscali.de>
By author:    Matthias-Christian Ott <matthias.christian@tiscali.de>
In newsgroup: linux.dev.kernel
> 
> Hi!
> But maybe gcc 4 will get different later, so I think this patch makes sense.
> 

No, it doesn't.  You fork when you have a reason.  Eager forking is
*BAD*.

	-hpa
