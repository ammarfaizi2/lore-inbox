Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135222AbRDZQMt>; Thu, 26 Apr 2001 12:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135275AbRDZQMd>; Thu, 26 Apr 2001 12:12:33 -0400
Received: from mta8.srv.hcvlny.cv.net ([167.206.5.23]:4343 "EHLO mta8")
	by vger.kernel.org with ESMTP id <S133108AbRDZQMR>;
	Thu, 26 Apr 2001 12:12:17 -0400
Date: Thu, 26 Apr 2001 12:11:10 -0400
From: Alan Shutko <ats@acm.org>
Subject: Re: About rebuild 2.4.x kernel to support SMP.
In-Reply-To: <Pine.LNX.4.10.10104261641580.3902-100000@www.teaparty.net>
To: Vivek Dasmohapatra <vivek@etla.org>
Cc: Yiping Chen <YipingChen@via.com.tw>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Message-id: <877l07fxpm.fsf@wesley.springies.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/21.0.102
In-Reply-To: <Pine.LNX.4.10.10104261641580.3902-100000@www.teaparty.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Dasmohapatra <vivek@etla.org> writes:

> /proc/stat will contain n cpuN lines, where n is the number of processors 
> in your box, I think, or no such lines [just a cpu line] on a UP box.

No, I see 

cpu  830711 916 708342 3323709
cpu0 830711 916 708342 3323709

and

# CONFIG_SMP is not set

-- 
Alan Shutko <ats@acm.org> - In a variety of flavors!
The more control, the more that requires control.
