Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbUDONrO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 09:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbUDONrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 09:47:14 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:17359 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263798AbUDONrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 09:47:11 -0400
Message-ID: <407E9127.8070303@nortelnetworks.com>
Date: Thu, 15 Apr 2004 09:41:59 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Sam Ravnborg <sam@ravnborg.org>,
       Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: modules in 2.6 kernel - question for FAQ?
References: <200404142142.41137.arekm@pld-linux.org>	 <1081993968.17782.112.camel@bach> <20040415044452.GA2215@mars.ravnborg.org> <1082004860.17780.143.camel@bach>
In-Reply-To: <1082004860.17780.143.camel@bach>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:

> They can only do this if they're not using the kernel makefiles.  So I
> don't really think it's a priority...

Unfortunately some of us have no choice but to use binary-only drivers.

This is starting to change, but they are currently still needed for some 
hardware.

Chris
