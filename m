Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281210AbRK0S36>; Tue, 27 Nov 2001 13:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281322AbRK0S3t>; Tue, 27 Nov 2001 13:29:49 -0500
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:38148
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S281210AbRK0S3k>; Tue, 27 Nov 2001 13:29:40 -0500
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200111271805.fARI5aw23060@www.hockin.org>
Subject: Re: procfs bloat, syscall bloat [in reference to cpu affinity]
To: phil-linux-kernel@ipal.net (Phil Howard)
Date: Tue, 27 Nov 2001 10:05:36 -0800 (PST)
Cc: l-k@mindspring.com (Joe Korty),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <20011127080441.A12419@vega.ipal.net> from "Phil Howard" at Nov 27, 2001 08:04:41 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IWSTM that the way you would justify this being a system call would also
> suggest working with non-linux kernel developers (both open source as well
> as commercial) to determine a mutually agreed syntax/semantic for this
> call to further ensure the basis of the universality that ensure it will
> be one of those "forever" facilities, and maybe even make it into a future
> standard.
> 
> You opened the camel's mouth; do you want to check the teeth?


once again - pset IS a candidate for this interface.  (damn I need to
finish the 2.4 port).  http://www.hockin.org/~thockin/pset
