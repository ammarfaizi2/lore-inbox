Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279481AbRJXGzl>; Wed, 24 Oct 2001 02:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279483AbRJXGzc>; Wed, 24 Oct 2001 02:55:32 -0400
Received: from james.kalifornia.com ([208.179.59.2]:6951 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S279481AbRJXGzZ>; Wed, 24 Oct 2001 02:55:25 -0400
Message-ID: <3BD6653E.70906@blue-labs.org>
Date: Wed, 24 Oct 2001 02:52:46 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011019
X-Accept-Language: en-us
MIME-Version: 1.0
To: Petr Titera <owl@century.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: issue: deleting one IP alias deletes all
In-Reply-To: <Pine.LNX.4.33.0110240042570.1210-100000@u.domain.uli> <3BD65188.1060203@blue-labs.org> <02b601c15c53$c02f4990$0800a8c0@century.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree that the documentation for 'ip' is sparse or hard to grok. 
 Learn by example.  I have some scripts on http://blue-labs.org/, the 
rc.* scripts.  These two scripts are my live scripts and cover a lot of 
things from simple to advanced.

(comments appreciated for corrections or improvements)

David

Petr Titera wrote:

>>Actually it is quite sane.  The tool is not.
>>
>>Switch to 'ip' instead of 'ifconfig', several large distros now include
>>it.  Addresses can be added and removed completely indiscriminately on
>>interfaces.
>>
>I'd like to, but there's nothing like documentation with it.
>
>Petr
>
>P.S.: Yes I know about examples in Linux 2.4 routing, but manpage would be
>nicer.
>


