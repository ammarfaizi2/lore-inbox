Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbTJLUOY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 16:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbTJLUOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 16:14:24 -0400
Received: from mail.convergence.de ([212.84.236.4]:11215 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263522AbTJLUOX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 16:14:23 -0400
Message-ID: <3F89B61E.9090106@convergence.de>
Date: Sun, 12 Oct 2003 22:14:22 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: de-de, de-at, de, en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/14] LinuxTV.org DVB driver update
References: <20031011105320.1c9d46db.davem@redhat.com> <Pine.GSO.4.21.0310121115260.27309-100000@starflower.sonytel.be> <20031012110846.GA1677@mars.ravnborg.org>
In-Reply-To: <20031012110846.GA1677@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sam,

>>>It is your responsibility to resolve such things though.  It is
>>>inevitable and unavoidable that others outside of your development
>>>group will make many changes to your files, as we fix bugs that
>>>are tree-wide.
>>
>>So you best subscribe to bk-commits-head and monitor every patch that affects
>>drivers/media/dvb/.
> 
> 
> Or more simple - keep a copy of the kernel where your patches got applied,
> and make a diff between that kernel and latest.
> Apply that diff to your local tree, and you are up-to-date.
> 
> This gives a good opportunity to review what has been applied without
> passing the maintainer.

Yes, another good hint. Thanks!

> 	Sam

CU
Michael.

