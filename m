Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbVBANq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVBANq3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 08:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbVBANq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 08:46:28 -0500
Received: from jagor.srce.hr ([161.53.2.130]:51156 "EHLO jagor.srce.hr")
	by vger.kernel.org with ESMTP id S262016AbVBANq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 08:46:26 -0500
Message-ID: <41FF8427.5010702@spymac.com>
Date: Tue, 01 Feb 2005 14:29:11 +0100
From: zhilla <zhilla@spymac.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Really annoying bug in the mouse driver
References: <41E91795.9060609@web.de> <200501280206.06747.dtor_core@ameritech.net>
In-Reply-To: <200501280206.06747.dtor_core@ameritech.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:

>> Jan 15 13:33:36 vic kernel: psmouse.c: bad data from KBC - bad 
>> parity Jan 15 13:33:38 vic kernel: psmouse.c: Wheel Mouse at 
>> isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.
>> Sometimes, only one of these messages appears; the number of bytes
>> in the second message varies, but mostly it is 3.
> Hi, Could you please try the patch below?

hello.. i have 100% same problem.
(mouse misbehaving, and being unable to use this patch against 2.6.10)
mouse is MS-600, a relatively cheap no name optical mouse. cable is OK.
thank you for your patch, but could you post a version that can be
applied against 2.6.10 version? thanks!

