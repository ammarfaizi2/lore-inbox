Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131637AbRAYLnH>; Thu, 25 Jan 2001 06:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132664AbRAYLm5>; Thu, 25 Jan 2001 06:42:57 -0500
Received: from [202.9.161.7] ([202.9.161.7]:58360 "HELO
	pagladashu.naturesoft.com") by vger.kernel.org with SMTP
	id <S131637AbRAYLmo>; Thu, 25 Jan 2001 06:42:44 -0500
Message-ID: <3A701136.3010001@bigfoot.com>
Date: Thu, 25 Jan 2001 17:12:46 +0530
From: archan <devrootp@bigfoot.com>
Organization: Open Source Software
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-21mdk i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Gennerat <christian.gennerat@vz.cit.alcatel.fr>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc: lih <linux-india-help@lists.linux-india.org>
Subject: Re: cddrive problem in Toshiba Laptop with 2.4.0-test11 kernel
In-Reply-To: <3A66EE88.B77485DD@bigfoot.com> <3A66F1F5.16BA30DA@vz.cit.alcatel.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks Christian,
I have dloaded 2.4-final kernel from ftp.kernel.org and the problem is 
solved.

archan
devrootp@bigfoot.com
archanp@bigfoot.com


Christian Gennerat wrote:

> archan a écrit :
> 
>> I have compiled 2.4.0-test11 kernel for my Toshiba Laptop. Everything
>> works fine except the CDdrive. When I am trying to mount a iso-cd, it is
>> giving the following error
>>         _isofs_bmap: block >= EOF (1633681408, 2048)
> 
> 
> This problem is already fixed in  about 2.4.0-test15
> take the 2.4.0-final or 2.4.1-pre.x
> .


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
