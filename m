Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbTJ3NYz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 08:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbTJ3NYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 08:24:55 -0500
Received: from chaos.analogic.com ([204.178.40.224]:44687 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262456AbTJ3NYy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 08:24:54 -0500
Date: Thu, 30 Oct 2003 08:26:20 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Sreeram Kumar Ravinoothala <sreeram.ravinoothala@wipro.com>
cc: "Magnus Naeslund(t)" <mag@fbab.net>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: Question on SIGFPE
In-Reply-To: <94F20261551DC141B6B559DC491086727C8C70@blr-m3-msg.wipro.com>
Message-ID: <Pine.LNX.4.53.0310300824440.3540@chaos>
References: <94F20261551DC141B6B559DC491086727C8C70@blr-m3-msg.wipro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Oct 2003, Sreeram Kumar Ravinoothala wrote:

>
> Hi Mr Johnson,
>     Thanks for the mail. Actually I see that there is no fpu_control.h
> in my src.
>
> Thanks and Regards
> SReeram

With more recent C runtime libraries, the header is
/usr/include/fpu_control.h instead of /usr/include/i386/fpu_control.h

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


