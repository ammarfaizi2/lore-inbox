Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbUDJRVr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 13:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbUDJRVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 13:21:47 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:36370 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262068AbUDJRVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 13:21:46 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "J. Ryan Earl" <heretic@clanhk.org>, Mohamed Aslan <mkernel@linuxmail.org>
Subject: Re: Rewrite Kernel
Date: Sat, 10 Apr 2004 20:21:36 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20040407125406.209FC39834A@ws5-1.us4.outblaze.com> <4078280B.5080604@clanhk.org>
In-Reply-To: <4078280B.5080604@clanhk.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404102021.36745.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 April 2004 19:59, J. Ryan Earl wrote:
> Mohamed Aslan wrote:
> >i wanna to rewrite a version of linux kernel from scratch in assembly for
> > intel 386+ fo speed and a libc also in assembly for speed what do u think
> > guys
>
> I doubt you would be capable of generating assembly that would be any
> faster than gcc, and you would inherit all the accidental difficulties
> that come with engineering software at a lower-level.

No, writing 'better than gcc' assembly is easy, gcc is far from stellar
in this regard. But it's painfully slow and non-portable.
--
vda

