Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267468AbTBVTRz>; Sat, 22 Feb 2003 14:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267513AbTBVTRz>; Sat, 22 Feb 2003 14:17:55 -0500
Received: from mnh-1-19.mv.com ([207.22.10.51]:58628 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S267468AbTBVTRz>;
	Sat, 22 Feb 2003 14:17:55 -0500
Message-Id: <200302221921.OAA02596@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Zwane Mwaikambo <zwane@zwane.ca>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5][13/14] smp_call_function_on_cpu - UML 
In-Reply-To: Your message of "Fri, 14 Feb 2003 04:34:06 EST."
             <Pine.LNX.4.50.0302140411160.3518-100000@montezuma.mastecende.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 22 Feb 2003 14:21:33 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zwane@holomorphy.com said:
> One liner to fix num_cpus == 0 on SMP kernel w/ UP box 

Applied, thanks.

		Jeff

