Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288740AbSADT4m>; Fri, 4 Jan 2002 14:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288738AbSADT4c>; Fri, 4 Jan 2002 14:56:32 -0500
Received: from basket.ball.reliam.net ([213.91.6.7]:18185 "HELO
	basket.ball.reliam.net") by vger.kernel.org with SMTP
	id <S288735AbSADT41>; Fri, 4 Jan 2002 14:56:27 -0500
Message-ID: <3C3608FD.1010509@michael-klose.de>
Date: Fri, 04 Jan 2002 20:56:45 +0100
From: Michael Klose <mail@michael-klose.de>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:0.9.7+) Gecko/20020103
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: eepro100 kernel freeze / ISDN
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correction:

> In 2.4.15pre5 (in my opinion one of the most stable 2.4 kernels I have tested) it "only" crashed after transferring about 2-3 GB of data via 
> my laptop SMB share over the 100MBit switch to the linux server. 2.4.17 crashes after 100-200 GB of data transfer.


That should read: 2.4.17 crashes after about 100-200 MB - megabytes or 
mibibytes or whatever you call them now whereas 2.4.15pre5 only crashed 
after half a handful of gigabytes.




