Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266195AbUHFWnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266195AbUHFWnG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 18:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUHFWnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 18:43:06 -0400
Received: from hera.kernel.org ([63.209.29.2]:32423 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S266195AbUHFWnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 18:43:04 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Fri, 6 Aug 2004 22:42:06 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <cf11fu$hg5$1@terminus.zytor.com>
References: <200408060833.i768X6Z6005223@burner.fokus.fraunhofer.de> <20040806104026.GD24158@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1091832126 17926 127.0.0.1 (6 Aug 2004 22:42:06 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 6 Aug 2004 22:42:06 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040806104026.GD24158@DervishD>
By author:    DervishD <raul@pleyades.net>
In newsgroup: linux.dev.kernel
> 
> > BTW: I am using 'mailx' which is _the_ official mail reader from
> > the POSIX standard......
> 
>     POSIX may specify 'mailx' as the name of the official mail
> reader, I really don't know, but your 'mailx' is screwing the
> threads.
> 

POSIX specifies interfaces, not implementations.  It doesn't matter if
one particular implementation conforms to the POSIX mailx interface
for mail submission if its other interface (RFC 2821/2822) is broken.

	-hpa

