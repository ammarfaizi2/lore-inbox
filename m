Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277210AbRJaAOP>; Tue, 30 Oct 2001 19:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275990AbRJaAOI>; Tue, 30 Oct 2001 19:14:08 -0500
Received: from [207.8.4.6] ([207.8.4.6]:55584 "EHLO one.interactivesi.com")
	by vger.kernel.org with ESMTP id <S277295AbRJaAN6>;
	Tue, 30 Oct 2001 19:13:58 -0500
Message-ID: <3BDF423D.1060503@interactivesi.com>
Date: Tue, 30 Oct 2001 18:13:49 -0600
From: Timur Tabi <ttabi@interactivesi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Module Licensing?
In-Reply-To: <E15yi1Q-0001ad-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>files and closed-source .o files.  That is, it's "mixed source" - part of the 
>>driver is open-source and part is closed-source.  What happens if the 
>>open-source version of the driver is the only code that uses GPL-only symbols. 
>>  How is that handled?
>>
> 
> Well then the open source bit would be GPL which would mean you can;t link
> it with the binary bit.


Ah, but what happens if I distribute the source code, the closed-source .o 
files, and a makefile, and tell people that they should link it?  Am I 
violating the GPL, or is the end-user?

