Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264822AbSK0VRB>; Wed, 27 Nov 2002 16:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264839AbSK0VRB>; Wed, 27 Nov 2002 16:17:01 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:56283 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S264822AbSK0VRA>; Wed, 27 Nov 2002 16:17:00 -0500
Message-ID: <3DE537FC.6090105@nortelnetworks.com>
Date: Wed, 27 Nov 2002 16:24:12 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: how to list pci devices from userpace?  anything better than /proc/bus/pci/devices?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a situation where the userspace app needs to be able to deal with 
  two different models of hardware, each of which uses a slightly 
different api.

Is there any way that I can query the pci vendor/device numbers without 
having to parse ascii files in /proc?

Thanks,

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

