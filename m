Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311269AbSCQC6I>; Sat, 16 Mar 2002 21:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311263AbSCQC56>; Sat, 16 Mar 2002 21:57:58 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:54406 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S311269AbSCQC5s>; Sat, 16 Mar 2002 21:57:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Adam Keys <akeys@post.cis.smu.edu>
To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        Adam Keys <akeys@post.cis.smu.edu>
Subject: Re: [BK] Having a hard time updating by pre-patch
Date: Sat, 16 Mar 2002 20:57:18 -0600
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020317005425.TVMQ1147.rwcrmhc52.attbi.com@there> <20020317031527.A31674@devcon.net> <20020317024932.UNAN1214.rwcrmhc54.attbi.com@there>
In-Reply-To: <20020317024932.UNAN1214.rwcrmhc54.attbi.com@there>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020317025742.XKEO2626.rwcrmhc51.attbi.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 16, 2002 08:49, Adam Keys wrote:
> This looks like exactly what I need!  Except, the following is something I
> don't need:
>
> bk: slib.c:11283: sccs_getInit: Assertion `e' failed.

More specifically, this happens when bk receive is run

$ bk version
BitKeeper/Free version is bk-2.1.4b 20020208233540 for x86-glibc22-linux
Built by: lm@redhat71.bitmover.com in /build/bk-2.1.x-lm/src
Built on: Fri Feb  8 16:37:41 PST 2002

-- 
akk~
