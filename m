Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266092AbRF2OZw>; Fri, 29 Jun 2001 10:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266091AbRF2OZm>; Fri, 29 Jun 2001 10:25:42 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:54535 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S266092AbRF2OZd>;
	Fri, 29 Jun 2001 10:25:33 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Byeong-ryeol Kim <jinbo21@hananet.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: compile error about do_softirq in 2.4.5-ac21 
In-Reply-To: Your message of "Fri, 29 Jun 2001 19:41:06 +0900."
             <Pine.LNX.4.33.0106291939100.8064-100000@progress.plw.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 30 Jun 2001 00:25:28 +1000
Message-ID: <27681.993824728@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jun 2001 19:41:06 +0900 (KST), 
Byeong-ryeol Kim <jinbo21@hananet.net> wrote:
>background.c:57: `do_softirq_Rf0a529b7' undeclared (first use in \
>                this function)

2.4.5-ac21 compiles and loads for me with module symbols turned on.
Try the procedure in http://www.tux.org/lkml/#s8-8.

