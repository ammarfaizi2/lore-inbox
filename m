Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285574AbRLGVjp>; Fri, 7 Dec 2001 16:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285569AbRLGViU>; Fri, 7 Dec 2001 16:38:20 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:7165 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S285566AbRLGViK>;
	Fri, 7 Dec 2001 16:38:10 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15377.13976.342104.636304@napali.hpl.hp.com>
Date: Fri, 7 Dec 2001 13:37:28 -0800
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Andrew Morton <akpm@zip.com.au>, j-nomura@ce.jp.nec.com,
        linux-kernel@vger.kernel.org, David Mosberger <davidm@hpl.hp.com>
Subject: Re: [PATCH] 2.4.16 kernel/printk.c (per processorinitializationcheck)
In-Reply-To: <Pine.LNX.4.21.0112071651360.22868-100000@freak.distro.conectiva>
In-Reply-To: <3C103A1E.2524A7B7@zip.com.au>
	<Pine.LNX.4.21.0112071651360.22868-100000@freak.distro.conectiva>
X-Mailer: VM 6.76 under Emacs 20.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 7 Dec 2001 16:52:07 -0200 (BRST), Marcelo Tosatti <marcelo@conectiva.com.br> said:

  Marcelo> I'm really not willing to apply this kludge...

Do you agree that it should always be safe to call printk() from C code?

	--david
