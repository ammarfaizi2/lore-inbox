Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbVELOQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbVELOQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 10:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbVELOQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 10:16:58 -0400
Received: from twin.uoregon.edu ([128.223.214.27]:64968 "EHLO twin.uoregon.edu")
	by vger.kernel.org with ESMTP id S261950AbVELOQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 10:16:56 -0400
Date: Thu, 12 May 2005 07:14:40 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Raphael Jacquot <raphael.jacquot@imag.fr>
cc: "P.Manohar" <pmanohar@lantana.cs.iitm.ernet.in>,
       linux-kernel@vger.kernel.org, industeqsite@industeqsite.com
Subject: Re: remote keyboard
In-Reply-To: <4282E3C0.8080604@imag.fr>
Message-ID: <Pine.LNX.4.62.0505120714010.28252@twin.uoregon.edu>
References: <Pine.LNX.4.60.0505121017090.31256@lantana.cs.iitm.ernet.in>
 <4282E3C0.8080604@imag.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2005, Raphael Jacquot wrote:

> P.Manohar wrote:
>>
>> " I am planning to have remote keyboard to control the operations on a
>>  particular target. To explain in detail, I will have a PC with keyboard,
>>  mouse etc and this PC will be connected to another PC(Remote) via
>> Ethernet.
>> Instead of using the local keyboard input, I want sent the keyboard keys
>> from the remote system (another PC via Ethernet) and use it as if it from
>>  the local keyboard.
>>
>> My Plan
>>  I am planning to use the Linux keyboard driver and read the keyboard
>> buffer
>> from the remote PC and send it to the target PC, and in the target PC
>>  whatever the key code I have received through the Ethernet I will put it
>> into the local keyboard buffer using the Linux keyboard driver IOCTLs.
>>
>>  Can anybody tell me is this acceptable "

VNC would probably be slightly more expedient.

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu 
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2

