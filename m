Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317862AbSHTNmS>; Tue, 20 Aug 2002 09:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317977AbSHTNmS>; Tue, 20 Aug 2002 09:42:18 -0400
Received: from [204.60.9.96] ([204.60.9.96]:19664 "HELO myeastern.com")
	by vger.kernel.org with SMTP id <S317862AbSHTNmR>;
	Tue, 20 Aug 2002 09:42:17 -0400
Message-ID: <3D62482D.4030500@myeastern.com>
Date: Tue, 20 Aug 2002 09:46:21 -0400
From: Rohan Deshpande <rohan@myeastern.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020818
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Wiesecke <j_wiese@hrzpub.tu-darmstadt.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: P4 with i845E not booting with 2.4.19 / 3.5.31
References: <3D6245DC.3A189656@hrzpub.tu-darmstadt.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Wiesecke wrote:
hi there,

something to the same extent happened to me, with my P4, as ACPI caused 
a kernel panic.  if you have acpi enabled, try disabling it.  

HTH,
-R

>Hi,
>
>I have the problem that my new P4 (1.6 GHz Northwood) box with i845E
>chipset doesn't boot with the 2.4.19(-pre2) kernel nor with the 2.5.31
>kernel (I also tested RedHat and Suse kernels without success). But it
>does boot with the late 2.2 series kernels (I tested 2.2.19 and 2.2.21).
>After displaying the message "umcompressing linux ... ok. Bootig the
>kernel" nothing else happens.
>
>Can anybody please give me a hint how I can look for further debug
>information ?
>
>Best regards
>  
>



