Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262825AbVAKQ6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262825AbVAKQ6E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 11:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262858AbVAKQ5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 11:57:21 -0500
Received: from fire.osdl.org ([65.172.181.4]:43990 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262825AbVAKQrn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 11:47:43 -0500
Message-ID: <41E4000D.1010708@osdl.org>
Date: Tue, 11 Jan 2005 08:34:21 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sounak chakraborty <sounakrin@yahoo.co.in>
CC: linux-kernel@vger.kernel.org
Subject: Re: syslog with syscall3
References: <20050111121248.67799.qmail@web53306.mail.yahoo.com>
In-Reply-To: <20050111121248.67799.qmail@web53306.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sounak chakraborty wrote:
> dear sir,
> i am facing some problem when i want to retrieve the
> lines of 
> information from the log file i.e from /var/log/messages

> i am using syslog function with syscall3 macro.it is
> showing the output 
> correctly but whenever i am declaring the structures
> of sockets it is showing segmentation fault 

Are there any oops messages in the kernel log?

Please post your source code (it is userspace or in-kernel?).

TIA.

> how to correctt it 
> is it so that my syscall 3 macro changing the program
> to kernel mode 
> and all the socket functions are not in or different
> in kernel mode ?
> then what will be the possible solution if i want t
> retrieve the information from logfile and send it to a file.

> thanks in advance 
> sounak

-- 
~Randy
