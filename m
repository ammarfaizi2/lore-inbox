Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLSJyP>; Tue, 19 Dec 2000 04:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129752AbQLSJyF>; Tue, 19 Dec 2000 04:54:05 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:54281 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129340AbQLSJxv>;
	Tue, 19 Dec 2000 04:53:51 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: M Sweger <mikesw@whiterose.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.2.19pre1 oops on cpuid 
In-Reply-To: Your message of "Mon, 18 Dec 2000 10:35:58 CDT."
             <Pine.LNX.4.21.0012181029270.3478-100000@whiterose.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 19 Dec 2000 20:23:18 +1100
Message-ID: <1274.977217798@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2000 10:35:58 -0500 (EST), 
M Sweger <mikesw@whiterose.net> wrote:
>    Question:  Is it possible to update the ksymoops utility to a 
>     newer version vs. the one supplied which  is v0.6?

Read the warning message.  ksymoops is separate from the kernel after 2.2.

  WARNING: This version of ksymoops is obsolete.
  WARNING: The current version can be obtained from ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
