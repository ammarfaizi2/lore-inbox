Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270772AbTHFSDv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 14:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270813AbTHFSDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 14:03:51 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:24337 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S270772AbTHFSDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 14:03:50 -0400
Message-ID: <3F314603.7050907@techsource.com>
Date: Wed, 06 Aug 2003 14:16:35 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Schmielau <tim@physik3.uni-rostock.de>
CC: Patrick Moor <pmoor@netpeople.ch>, lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>
Subject: Re: time jumps (again)
References: <Pine.LNX.4.33.0308042347300.12309-100000@gans.physik3.uni-rostock.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any way the kernel could detect clock problems like drift and 
jumps by comparing the effects of different timers?  And when a problem 
is detected, it can correct the situation automatically.

How many interrupt timers are there in various systems?  How much can we 
rely on the accuracy of each one?

