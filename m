Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbUCHNoM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 08:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbUCHNoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 08:44:12 -0500
Received: from komp197.tera.com.pl ([81.21.195.197]:11167 "EHLO wrota.net")
	by vger.kernel.org with ESMTP id S262486AbUCHNoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 08:44:10 -0500
Date: Mon, 8 Mar 2004 14:44:10 +0100
From: Daniel Fenert <daniel@fenert.net>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is there some bug in ext3 in 2.4.25?
Message-ID: <20040308134410.GU18915@fenert.net>
Mail-Followup-To: Daniel Fenert <daniel@fenert.net>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0403051048160.2678-100000@dmt.cyclades> <1078496713.14033.53.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1078496713.14033.53.camel@sisko.scot.redhat.com>
User-Agent: Mutt/1.4.2i
Organization: Co by tu =?iso-8859-2?B?d3Bpc2HmPyBNb78=?=
	=?iso-8859-2?Q?e?= daniellek.z.domu ? ;)
X-Operating-System: Linux 2.4.24
X-Wyslij-mi-SMSa: Lepiej nie...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu Fri, Mar 05, 2004 at 02:25:13PM +0000, Stephen C. Tweedie wystuka³(a):
>> This sounds like memory corruption (which could be caused by a misbehaving
>> driver or by flaky hardware) because transaction->t_ilist is not used at
>> all by the kernel code. Did this box run stable with other kernels?
>
>Sounds like bad memory to me.  The only other report of this I've seen
>was at
>
>https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=115935
>
>and that machine didn't pass memtest86.

I'll check this this week, BIG thanks for replies.

(the machine was stable for few years, AFAIR 3 years).

-- 
Daniel Fenert                 --==> daniel@fenert.net <==--
==-P o w e r e d--b y--S l a c k w a r e-=-ICQ #37739641-==
Who does not love wine, women, and song, remains a fool his whole life long.
=======- http://daniel.fenert.net/ -=======< +48604628083 >
