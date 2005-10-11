Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbVJKLYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbVJKLYO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 07:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbVJKLYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 07:24:14 -0400
Received: from mail.gmx.de ([213.165.64.20]:28068 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751458AbVJKLYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 07:24:14 -0400
X-Authenticated: #4395837
Message-ID: <434BA0DB.6040509@gmx.de>
Date: Tue, 11 Oct 2005 13:24:11 +0200
From: Cornelius Thiele <thielec@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20051008)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dual Xeon Time skips with 2.6
References: <4WbFk-3iC-33@gated-at.bofh.it> <434AC72F.8070701@shaw.ca>
In-Reply-To: <434AC72F.8070701@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
  > You can probably avoid this problem by using "notsc" on the kernel
> command line. It would seem that somehow the TSC drift is too small for 
> the kernel to notice on boot, but causes problems anyway..

Thanks very much, that fixed it.

Greetings,
	Cornelius Thiele
