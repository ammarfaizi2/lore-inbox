Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264498AbUAaKs3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 05:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264510AbUAaKs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 05:48:29 -0500
Received: from pop.gmx.de ([213.165.64.20]:1237 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264498AbUAaKs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 05:48:29 -0500
X-Authenticated: #4512188
Message-ID: <401B87F4.5040702@gmx.de>
Date: Sat, 31 Jan 2004 11:48:20 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Nigel Cunningham <ncunningham@clear.net.nz>, trelane@digitasaru.net,
       Luke-Jr <luke7jr@yahoo.com>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] Software Suspend 2.0
References: <1075436665.2086.3.camel@laptop-linux> <200401310622.17530.luke7jr@yahoo.com> <1075531042.18161.35.camel@laptop-linux> <20040131064757.GB7245@digitasaru.net> <1075532166.17727.41.camel@laptop-linux> <20040131071619.GD7245@digitasaru.net> <1075534088.18161.61.camel@laptop-linux> <20040131073848.GE7245@digitasaru.net> <1075537924.17730.88.camel@laptop-linux> <401B6F7A.5030103@gmx.de> <1075540107.17727.90.camel@laptop-linux> <401B7312.3060207@gmx.de> <1075542685.25454.124.camel@laptop-linux> <401B86EB.50604@gmx.de>
In-Reply-To: <401B86EB.50604@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash K. Cheemplavam wrote:

> I compiled into kernel /dev/hde5 and put resume2=swap:/dev/hde5 into 
> kernel paramters at grung.conf. Shouldn't that work?

It should be "grub.conf", of course.

Prakash
