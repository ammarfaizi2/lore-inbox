Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265656AbUATSRc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 13:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265657AbUATSRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 13:17:32 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:27838 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265656AbUATSR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 13:17:29 -0500
Message-ID: <400D7061.9060608@nortelnetworks.com>
Date: Tue, 20 Jan 2004 13:16:01 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Zan Lynx <zlynx@acm.org>
Cc: root@chaos.analogic.com, Bart Samwel <bart@samwel.tk>,
       Ashish sddf <buff_boulder@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ kernel module + Makefile
References: <20040116210924.61545.qmail@web12008.mail.yahoo.com>	 <Pine.LNX.4.53.0401161659470.31455@chaos>	 <200401171359.20381.bart@samwel.tk>	 <Pine.LNX.4.53.0401190839310.6496@chaos> <400C1682.2090207@samwel.tk>	 <Pine.LNX.4.53.0401191311250.8046@chaos> <400C37E3.5020802@samwel.tk>	 <Pine.LNX.4.53.0401191521400.8389@chaos> <400C4B17.3000003@samwel.tk>	 <Pine.LNX.4.53.0401201000490.11497@chaos> <1074620079.22023.26.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zan Lynx wrote:

> I like C++ and hate to see it so unfairly maligned.  Here's a much
> better example:

> Both programs contain exactly the same code: one main() function using
> puts("Hello world!").

Just to pick a nit, if you use cout (as most C++ people would) the size 
goes up by another couple hundred bytes.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

