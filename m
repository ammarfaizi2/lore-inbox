Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWDFVVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWDFVVl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 17:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWDFVVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 17:21:41 -0400
Received: from mail.gmx.de ([213.165.64.20]:63725 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751324AbWDFVVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 17:21:41 -0400
X-Authenticated: #13243522
Message-ID: <4435865D.9020608@gmx.de>
Date: Thu, 06 Apr 2006 23:21:33 +0200
From: Michael Schierl <schierlm@gmx.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
MIME-Version: 1.0
To: Martin Michlmayr <tbm@cyrius.com>
CC: linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: Linux 2.6.17-rc1
References: <Pine.LNX.4.64.0604022037380.3781@g5.osdl.org> <e0r09j$gu5$1@sea.gmane.org> <20060403194727.GD5616@flint.arm.linux.org.uk> <20060406142727.GA22724@unjust.cyrius.com>
In-Reply-To: <20060406142727.GA22724@unjust.cyrius.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Michlmayr schrieb:
> * Russell King <rmk+lkml@arm.linux.org.uk> [2006-04-03 20:47]:
>>> kernel/built-in.o:(.data+0x758): undefined reference to `uevent_helper'
>>> make: *** [.tmp_vmlinux1] Error 1
>> I've reported this bug several times but I seem to be getting absolutely
>> no response.  So I submitted it to bugzilla.
>> http://bugzilla.kernel.org/show_bug.cgi?id=6306
>>
>> Feel free to add your voice to that bug to try to get someone to fix it.
>> I'm not hopeful though.
> 
> Kay Sievers has added a patch to Bugzilla a few days ago.  Can you
> confirm that it works?

It does indeed work for me,

Thank you,

Michael
