Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265494AbTFVDzi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 23:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265498AbTFVDzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 23:55:38 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:61378 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265494AbTFVDzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 23:55:37 -0400
Message-ID: <3EF52C00.6080206@nortelnetworks.com>
Date: Sun, 22 Jun 2003 00:09:36 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: jcwren@jcwren.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel facilities for tracking file accesses
References: <20030621204615.GA32341@peter.cfs> <3EF4DCEF.7080708@yahoo.ca> <200306211845.41702.jcwren@jcwren.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.C. Wren wrote:
> 	Does any facility exist in the 2.4 and up kernels for logging *every* open, 
> read, write, seek, close, etc call?  

Can't you just use strace against the daemon?

> I would prefer something 
> that monitors the entire system, rather than trying to sandbox this 
> particular program (it runs as a daemon).

How about the Linux Trace Toolkit?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

