Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268911AbRHFWZX>; Mon, 6 Aug 2001 18:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269067AbRHFWZN>; Mon, 6 Aug 2001 18:25:13 -0400
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:48393 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S268911AbRHFWY6>; Mon, 6 Aug 2001 18:24:58 -0400
X-Apparently-From: <kiwiunixman@yahoo.co.nz>
Message-ID: <3B6F1941.5000709@yahoo.co.nz>
Date: Tue, 07 Aug 2001 10:25:05 +1200
From: Matthew Gardiner <kiwiunixman@yahoo.co.nz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-gb
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.8-pre4, lots of compile warnings
In-Reply-To: <848.997076771@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snype a roo>

All that is happening is the compiler is saying that variables have been declared, 
however, they haven't been used, aka, they aren't errors. What is happening is that 
all variables required have been declared my that particular maintainer, and as the 
programmers go along, they will gradually use the variables up. This normally occurs 
when a driver is still development.

Matthew Gardiner

-- 
I am the blue screen of death
no body can hear your screams

You can't spell Linux with out U N I X


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

