Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131275AbRDXI0X>; Tue, 24 Apr 2001 04:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131446AbRDXI0O>; Tue, 24 Apr 2001 04:26:14 -0400
Received: from fluent1.pyramid.net ([206.100.220.212]:40246 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S131275AbRDXIZ5>; Tue, 24 Apr 2001 04:25:57 -0400
Message-Id: <4.3.2.7.2.20010424012505.00b80590@mail.fluent-access.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 24 Apr 2001 01:25:43 -0700
To: linux-kernel@vger.kernel.org
From: Stephen Satchell <satch@fluent-access.com>
Subject: Re: [PATCH] pedantic code cleanup - am I wasting my time with
  this?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:58 PM 4/23/01 +0200, you wrote:
>>On Mon, Apr 23, 2001 at 05:26:27PM +0200, Jesper Juhl wrote:
>>>last entry should not have a trailing comma.
>>Sadly not.  This isn't a gcc thing: ANSI says that trailing comma is ok (K&R
>>Second edition, A8.7 - pg 218 &219 in my copy)
>
>You are right, I just consulted my own copy, and nothing strictly forbids 
>the comma... Sorry about that, I should have been more thorough before 
>reporting that one...

 From the X3J11 Rationale document, paraphrase:  The inclusion of optional 
trailing commas is to ease the task of generating code by automatic 
programs such as LEX and YACC.

Satch

