Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292900AbSBVPnt>; Fri, 22 Feb 2002 10:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292911AbSBVPnj>; Fri, 22 Feb 2002 10:43:39 -0500
Received: from callisto.affordablehost.com ([64.23.37.14]:49937 "HELO
	callisto.affordablehost.com") by vger.kernel.org with SMTP
	id <S292900AbSBVPnV>; Fri, 22 Feb 2002 10:43:21 -0500
Message-ID: <3C766728.1050702@keyed-upsoftware.com>
Date: Fri, 22 Feb 2002 09:43:36 -0600
From: David Stroupe <dstroupe@keyed-upsoftware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Q:Resetting driver from within
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If I need to reset my driver and have it reprobe the pci bus under 
software control, can I call the init and exit functions directly?
TIA
David

-- 
Best regards,
David Stroupe
Keyed-Up Software 


