Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288127AbSBKLn3>; Mon, 11 Feb 2002 06:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288158AbSBKLnT>; Mon, 11 Feb 2002 06:43:19 -0500
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:52876 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S288127AbSBKLnM>; Mon, 11 Feb 2002 06:43:12 -0500
Message-ID: <3C67AFD3.722C5471@ntlworld.com>
Date: Mon, 11 Feb 2002 11:49:39 +0000
From: SA products <super.aorta@ntlworld.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: faking time
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Kernel list,

I want to fake the time returned by the time() system call so that for a
limited number
of user space programs the time can be set to the future or the past
without affecting
other applications and without affecting system time-- Ideally I would
like to install a
loadable module to accomplish this- Any hints ? Any starting points?

Thanks SA

