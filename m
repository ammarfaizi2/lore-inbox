Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317694AbSHKFS0>; Sun, 11 Aug 2002 01:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317708AbSHKFS0>; Sun, 11 Aug 2002 01:18:26 -0400
Received: from clmboh1-smtp4.columbus.rr.com ([65.24.0.114]:32209 "EHLO
	clmboh1-smtp4.columbus.rr.com") by vger.kernel.org with ESMTP
	id <S317694AbSHKFS0>; Sun, 11 Aug 2002 01:18:26 -0400
Message-ID: <3D55F484.9090403@cinci.rr.com>
Date: Sun, 11 Aug 2002 01:22:12 -0400
From: Nathaniel <nwf@cinci.rr.com>
Organization: BentTroll Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020710
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.31
References: <Pine.LNX.4.33.0208101854340.2656-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another piece of trivia:  drivers/acpi/system.c still needs a "#include <linux/interrupts.h>"

--Nathan

