Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267662AbUHYEYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267662AbUHYEYY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 00:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267669AbUHYEYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 00:24:24 -0400
Received: from hera.kernel.org ([63.209.29.2]:26594 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S267662AbUHYEYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 00:24:23 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: Linux 2.6.9-rc1
Date: Wed, 25 Aug 2004 04:24:11 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <cgh49b$hj2$1@terminus.zytor.com>
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org> <cggjvs$bv9$1@sea.gmane.org> <412BD946.1080908@linux-user.net> <805tv1-ec2.ln1@tux.abusar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1093407851 18019 127.0.0.1 (25 Aug 2004 04:24:11 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 25 Aug 2004 04:24:11 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <805tv1-ec2.ln1@tux.abusar.org>
By author:    fraga@abusar.org ( =?ISO-8859-1?Q?D=E2niel?= Fraga)
In newsgroup: linux.dev.kernel
> 
> 	Ok, I understand the problem. But isn't it possible to avoid
> releasing some 2.6.8.x version after 2.6.9? I mean, I'm not
> understanding why this could happen.
> 
> 	Ps: sorry if this question is silly, but I didn't get the point why
> 2.6.8.2 could be released after 2.6.9.
> 

Because people don't want to upgrade to 2.6.9 for some reason (too big
of a change.)  Kind of like why we're still supporting 2.4, 2.2 and
(to some degree) 2.0.

	-hpa

