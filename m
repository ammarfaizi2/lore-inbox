Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269876AbRHDXFN>; Sat, 4 Aug 2001 19:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269875AbRHDXFD>; Sat, 4 Aug 2001 19:05:03 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:15878 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S269876AbRHDXEx>; Sat, 4 Aug 2001 19:04:53 -0400
X-Apparently-From: <kiwiunixman@yahoo.co.nz>
Message-ID: <3B6C7F9B.30303@yahoo.co.nz>
Date: Sun, 05 Aug 2001 11:04:59 +1200
From: Matthew Gardiner <kiwiunixman@yahoo.co.nz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-gb
MIME-Version: 1.0
To: Tom Vier <tmv5@home.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.7-ac4 disk thrashing
In-Reply-To: <20010804113841.A2196@zero>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Vier wrote:

>switching from 2.4.7-ac3 to -ac4, disk access seems to be much more
>synchronis. running a ./configure script causes all kinds of trashing, as
>does installing .debs. i'm using reiserfs on top of software raid 0 on an
>alpha.
>
Apparently, in ac5 (which I am running), there was a bug on non-x86 
cpu's using reiserfs. Download and install the new patch and try.

Matthew Gardiner



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

