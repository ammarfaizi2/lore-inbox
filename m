Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267076AbTBHTbn>; Sat, 8 Feb 2003 14:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267078AbTBHTbn>; Sat, 8 Feb 2003 14:31:43 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:2435 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S267076AbTBHTbn>; Sat, 8 Feb 2003 14:31:43 -0500
From: David Woodhouse <dwmw2@infradead.org>
To: Nandakumar NarayanaSwamy <nanda_kn@rediffmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030208142009.17031.qmail@webmail29.rediffmail.com>
References: <20030208142009.17031.qmail@webmail29.rediffmail.com>
Organization: 
Message-Id: <1044733282.2943.34.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 08 Feb 2003 19:41:22 +0000
Subject: Re: File systems in embedded devices
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-02-08 at 14:20, Nandakumar NarayanaSwamy wrote:
> Dear All,
> 
> We are developing a embedded device based on linux. Through the 
> development phase we used NFS. But now we want to move some 
> filesystem which can be created in FLASH/RAM.

Which? Flash or RAM?

> Can anybody suggest me some ideas so that i can solve these 
> issues?

You need to give at least _some_ indication of your requirements --
what's on your file system, what is the expected pattern of access to
it, do you require write access all the time or only occasional updates
of the whole system, etc. ?


-- 
dwmw2

