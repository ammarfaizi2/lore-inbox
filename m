Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262667AbVFWK2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbVFWK2W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 06:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbVFWKX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 06:23:59 -0400
Received: from reserv6.univ-lille1.fr ([193.49.225.20]:23787 "EHLO
	reserv6.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S262667AbVFWKP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 06:15:27 -0400
Message-ID: <42BA89B4.50900@tremplin-utc.net>
Date: Thu, 23 Jun 2005 12:06:44 +0200
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Alejandro Bonilla <abonilla@linuxwireless.org>,
       "'Pavel Machek'" <pavel@ucw.cz>, "'Lee Revell'" <rlrevell@joe-job.com>,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>,
       linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
Subject: Re: [ltp] Re: IBM HDAPS Someone interested?
References: <20050622104927.GB2561@openzaurus.ucw.cz> <001201c57729$0a645840$600cc60a@amer.sykes.com> <20050623071345.GA4553@ucw.cz>
In-Reply-To: <20050623071345.GA4553@ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-MailScanner-From: eric.piel@tremplin-utc.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

06/23/2005 09:13 AM, Vojtech Pavlik wrote/a écrit:
> On Wed, Jun 22, 2005 at 06:50:59AM -0600, Alejandro Bonilla wrote:
> 
>>/proc/acpi/ibm/ecdump is really not providing any information about this
>>sensor. yesterday, I almost broke the laptop to see if it would generate
>>anything, but it really only outputs ACPI events...
>>
>>I shaked it, moved it 90deg and still no result, threw the lappy from like
>>40cm to the bed and nothing was really generated. Unless it is too fast like
>>to generate it in the watch or to be seen by human eye. I dunno.
>>
>>It looks like /ecdump won't do it.
> 
>  
> But that doesn't mean it's not connected to the embedded controller. It
> just means the embedded controller doesn't generate any inertial events
> by itself - it may have to be polled with some specific command.
> 

Well, in the changelog of the embedded controller firmware 
(ftp://ftp.software.ibm.com/pc/pccbbs/mobiles/1uhj07us.txt) there is:
- (New) Support for IBM Hard Disk Active Protection System.

I would conclude that the embedded controller is involved with the HDAPS!

Just my two cents.

Eric
