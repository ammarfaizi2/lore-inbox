Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291846AbSBXXaH>; Sun, 24 Feb 2002 18:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291853AbSBXX3x>; Sun, 24 Feb 2002 18:29:53 -0500
Received: from callisto.affordablehost.com ([64.23.37.14]:18189 "HELO
	callisto.affordablehost.com") by vger.kernel.org with SMTP
	id <S291840AbSBXX3f>; Sun, 24 Feb 2002 18:29:35 -0500
Message-ID: <3C797770.3000206@keyed-upsoftware.com>
Date: Sun, 24 Feb 2002 17:29:52 -0600
From: David Stroupe <dstroupe@keyed-upsoftware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Q: Interfacing to driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have created a driver for a custom board.  This driver exports the 
functions that I need to access from my user programs to control the 
card.  How do I declare and call this driver function within my user 
code so that it will call the device driver function?
TIA

-- 
Best regards,
David Stroupe
Keyed-Up Software 


