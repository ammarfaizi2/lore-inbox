Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130029AbQLGXpP>; Thu, 7 Dec 2000 18:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130786AbQLGXpF>; Thu, 7 Dec 2000 18:45:05 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:33298 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130029AbQLGXo7>;
	Thu, 7 Dec 2000 18:44:59 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Joseph Cheek <joseph@cheek.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at buffer.c:827 in test12-pre6 and 7 
In-Reply-To: Your message of "Thu, 07 Dec 2000 14:42:38 -0800."
             <3A30125D.5F71110D@cheek.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Dec 2000 10:14:28 +1100
Message-ID: <5837.976230868@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Dec 2000 14:42:38 -0800, 
Joseph Cheek <joseph@cheek.com> wrote:
>loop.o built as module.  this hard crashes the machine, every time
>[PIII-450].  i don't know how to debug this, is there a FAQ?

linux/Documentation/oops-tracing.txt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
