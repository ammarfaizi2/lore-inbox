Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbUEBElM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUEBElM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 00:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUEBElM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 00:41:12 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:50883 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261181AbUEBElB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 00:41:01 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: "'Paul Jackson'" <pj@sgi.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Large page support in the Linux Kernel?
Date: Sat, 1 May 2004 21:45:29 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20040501033612.0078b26f.pj@sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcQvZ/8Gcx+u9FwvTfO1rhNHDcs6qQAmEYhA
Message-Id: <S261181AbUEBElB/20040502044101Z+1560@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yup, this is it. Thanks :)

--Buddy

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Paul Jackson
Sent: Saturday, May 01, 2004 3:36 AM
To: Buddy Lumpkin
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large page support in the Linux Kernel?

> I was wondering if there is going to be large page support for the linux
> kernel in the near future.

Do a search in this lkml for "hugetlb",  and read the linux file
Documentation/vm/hugetlbpage.txt.  Is that what you're looking for?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

