Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbUCENJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 08:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbUCENJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 08:09:56 -0500
Received: from av8.netikka.fi ([213.250.83.8]:8131 "EHLO mail.linuxvaasa.com")
	by vger.kernel.org with ESMTP id S262591AbUCENJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 08:09:54 -0500
Message-ID: <40487C20.7030002@netikka.fi>
Date: Fri, 05 Mar 2004 15:09:52 +0200
From: Johnny Strom <jonny.strom@netikka.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: sv, en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, jr@xor.at
Subject: Re: Multiple oopses with 2.4.25
References: <Pine.LNX.4.44.0403050914450.2678-100000@dmt.cyclades>
In-Reply-To: <Pine.LNX.4.44.0403050914450.2678-100000@dmt.cyclades>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> On Wed, 3 Mar 2004, Johnny Strom wrote:
> 
> 
>>Hi
>>
>>It seems that I have the same problem as in this
>>mail:
>>
>>http://www.ussg.iu.edu/hypermail/linux/kernel/0403.0/0635.html
>>
>>
>>I also get multiple oopse's with 2.4.25 plus the latest
>>ipsec kernel patch form http://www.freeswan.org/.
>>
>>I have to reset the computer to get it working again,
>>below is the oopse's:
> 
> 
> Dear fellows,
> 
> I have seen similar reports. 
> 
> Can you find out which kernel does not exhibit the behaviour with the same
> freeswan/grsec patches ?
> 
> 
> 

Well I have been running 2.4.24 plus the freeswan patch for over a month 
and I had no problems att all. It is only with 2.4.25 plus the freeswan 
patch that I saw this oops, note that it have only happend once with 
2.4.25 and I have no idea how to trigger it yet.


So I think this started to happen with 2.4.25 plus the freeswan patch.











