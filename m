Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752325AbWJOBYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbWJOBYu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 21:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752327AbWJOBYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 21:24:50 -0400
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:21422 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752320AbWJOBYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 21:24:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=sbcglobal.net;
  h=Received:Mime-Version:In-Reply-To:References:Content-Type:Message-Id:Content-Transfer-Encoding:From:Subject:Date:To:X-Mailer;
  b=jN3wpu3mGBkMbnCzq6ZJMKos9nZUQQnxHGXqmFzb2Sb7/0WieyemdnjWPCf1Ig3g3GaIlVeMtSHu1XT097DDQG6Ip5LK48G75S0SP5gHd1Kd4dfhacvBQFT5VgCrlRoCmi/xLlgUncccvr1Oki6STs5PPHQYEwFm3ae8KUSbrjI=  ;
Mime-Version: 1.0 (Apple Message framework v752.2)
In-Reply-To: <45317814.8000709@comcast.net>
References: <4530570B.7030500@comcast.net>	 <20061014075625.GA30596@stusta.de> <4530FC8E.7020504@comcast.net>	 <7E4CA247-AD0A-4A20-BEAF-CDD2CA4D3FFE@sbcglobal.net>	 <45315A20.6090600@comcast.net> <1160870637.5732.46.camel@localhost.localdomain> <45317814.8000709@comcast.net>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <73CDF2F1-EC0A-431D-9B29-10251FAD21B7@sbcglobal.net>
Content-Transfer-Encoding: 7bit
From: Kevin K <k_krieser@sbcglobal.net>
Subject: Re: Driver model.. expel legacy drivers?
Date: Sat, 14 Oct 2006 20:24:46 -0500
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Oct 14, 2006, at 6:51 PM, John Richard Moser wrote:

>
>> Microsoft are also being very helpful. They are making it harder and
>> harder for people to use drivers not microsoft-signed which in turns
>> pushes up costs for development and as a result encourages more
>> standardization of driver interfaces to take place.
>
> huh?
>

My assumption is that vendors may make fewer gratuitious interface  
changes so the hardware is more likely to work with existing, signed,  
drivers.  If changes aren't made, existing Linux drivers are more  
likely to work with new revisions of hardware.

My experience in the past for hardware, such as USB based flash  
memory readers, is that when they came out you seemed to always need  
a proprietary driver, and Linux drivers needed hints for different  
readers.  It seems better these days, with things like USB keys  
generally working in both Windows and relatively modern distributions  
without much effort.llin
