Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271467AbRIAWzg>; Sat, 1 Sep 2001 18:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271473AbRIAWz0>; Sat, 1 Sep 2001 18:55:26 -0400
Received: from mail.triton.net ([216.65.160.10]:10501 "HELO mail.triton.net")
	by vger.kernel.org with SMTP id <S271467AbRIAWzP>;
	Sat, 1 Sep 2001 18:55:15 -0400
Message-ID: <3B916760.1000104@lycosmail.com>
Date: Sat, 01 Sep 2001 18:55:28 -0400
From: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: USB trouble w/ 2.4.8-ac12
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 2.4.8-ac12, USB modules, and a Philips CDRW400.

I was able to get it to see the CDRW drive once(and that took a minute 
or three), but mostly it only sees the Freecom USB-IDE bridge.

How do I get the usb code to probe the ATAPI bridge for the devices 
behind it??

TIA
tabris

