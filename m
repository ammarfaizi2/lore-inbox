Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318202AbSHIJED>; Fri, 9 Aug 2002 05:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318203AbSHIJED>; Fri, 9 Aug 2002 05:04:03 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:59140 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S318202AbSHIJEC>;
	Fri, 9 Aug 2002 05:04:02 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: modutils for 2.0.40 
In-reply-to: Your message of "Wed, 07 Aug 2002 14:48:09 CST."
             <Pine.LNX.4.44.0208071447430.10270-100000@hawkeye.luckynet.adm> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 09 Aug 2002 19:07:32 +1000
Message-ID: <2528.1028884052@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002 14:48:09 -0600 (MDT), 
Thunder from the hill <thunder@ngforever.de> wrote:
>What's the latest modutils version expected to work on 2.0?

2.4.19, as long as you build with -enable-compat-2-0.  At least that is
the theory, it is a long time since I tested modutils on a 2.0 system.

