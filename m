Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbSJORl0>; Tue, 15 Oct 2002 13:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264720AbSJORlY>; Tue, 15 Oct 2002 13:41:24 -0400
Received: from ns.ithnet.com ([217.64.64.10]:43281 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S264673AbSJORkE>;
	Tue, 15 Oct 2002 13:40:04 -0400
Date: Tue, 15 Oct 2002 19:45:38 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: nfs-server slowdown in 2.4.20-pre10 with client 2.2.19
Message-Id: <20021015194538.10f54ef3.skraw@ithnet.com>
In-Reply-To: <15786.15416.668502.225074@notabene.cse.unsw.edu.au>
References: <20021013172138.0e394d96.skraw@ithnet.com>
	<15785.64463.490494.526616@notabene.cse.unsw.edu.au>
	<20021014045410.4721c209.skraw@ithnet.com>
	<15786.15416.668502.225074@notabene.cse.unsw.edu.au>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2002 13:38:32 +1000
Neil Brown <neilb@cse.unsw.edu.au> wrote:

Hello Neil,
hello Trond,

> This night I will try to reduce rsize/wsize from the current 8192 down to
> 1024 as suggested by Jeff.

Ok. The result is: it is again way slower. I was not even capable to transfer 5
GB within 18 hours, that's when I shot the thing down.
Anything else I can test?

-- 
Regards,
Stephan
