Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130419AbRCCGKu>; Sat, 3 Mar 2001 01:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130422AbRCCGKl>; Sat, 3 Mar 2001 01:10:41 -0500
Received: from Huntington-Beach.blue-labs.org ([208.179.59.198]:52286 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S130419AbRCCGKa>; Sat, 3 Mar 2001 01:10:30 -0500
Message-ID: <3AA08AB2.4090305@blue-labs.org>
Date: Fri, 02 Mar 2001 22:09:54 -0800
From: David <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-ac3 i686; en-US; 0.9) Gecko/20010302
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: TCP window shrinkers
In-Reply-To: <3AA06208.3090806@blue-labs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David wrote:

> http://stuph.org/tcp-window-shrinkers.txt is a list of 825 systems 
> that  generate this message.


Following up.., I scripted an nmap run, it is in html ;)

http://stuph.org/tcp-window-shrinkers.nmap.html

Format is:

   IP
   dns lookup
   nmap results
   [OS type]                      [Identified]

The script is running now, DNS is tacked in which makes the cycle take 
longer but helps to identify probable dynamic dialups.

Please use Mozilla or IE.  The output is usable in Netscape 4.x but suffers.

-d

