Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262281AbUJZOkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbUJZOkd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 10:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbUJZOkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 10:40:32 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:15542 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262281AbUJZOkZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 10:40:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=r0/Yw1bOjVpJakS560slPx27hFq9Xhp5KoFJjqSaV/mmeov2ccHZ9zWHcjMtDKGb5pqPYqr/2+6CpP+7sDZP5defAKitaeCC7M/i6NZxnCVCZZvTCNDwUnto0gT9cgwmHv+YjbB+5mWJUHdsky+HEfU2abwVo2L/NVCUahb4J3s=
Message-ID: <7aaed09104102607404ca14119@mail.gmail.com>
Date: Tue, 26 Oct 2004 16:40:24 +0200
From: =?ISO-8859-1?Q?Espen_Fjellv=E6r_Olsen?= <espenfjo@gmail.com>
Reply-To: =?ISO-8859-1?Q?Espen_Fjellv=E6r_Olsen?= <espenfjo@gmail.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Subject: Re: My thoughts on the "new development model"
Cc: Ed Tomlinson <edt@aei.ca>, Chuck Ebbert <76306.1226@compuserve.com>,
       Bill Davidsen <davidsen@tmr.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041026123727.GA9375@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <200410260142_MC3-1-8D2A-45C2@compuserve.com>
	 <200410260644.47307.edt@aei.ca>
	 <20041026123727.GA9375@ip68-4-98-123.oc.oc.cox.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only reason that i brought this up again was that, as written
before, the kernel contains very much bad code. Very much could be
redone to gain both speed and security, imho.
I don't think such a brainstorm is going to happen within a 2.6 "stable" tree.
We need a 2.7 tree for this, then people might want to experiment with
rewrinting old code.

But im not an expert on the Linux kernel, i have no idea really.
I just startet to using 2.5/2.6 at some of the last 2.5 kernels.
That was a whole new world, you could really feel the improvments over 2.4.

-- 
Mvh / Best regards
Espen Fjellvær Olsen
espenfjo@gmail.com
Norway
