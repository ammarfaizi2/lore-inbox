Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270709AbRHPCkU>; Wed, 15 Aug 2001 22:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270710AbRHPCkK>; Wed, 15 Aug 2001 22:40:10 -0400
Received: from motgate4.mot.com ([144.189.100.102]:64754 "EHLO
	motgate4.mot.com") by vger.kernel.org with ESMTP id <S270709AbRHPCkA>;
	Wed, 15 Aug 2001 22:40:00 -0400
Message-ID: <C1590740235CD211BA5600A0C9E1F6FF02602296@hydmail.mihy.mot.com>
From: Sarada prasanna <csaradap@mihy.mot.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: _IOR('t',90,int)
Date: Thu, 16 Aug 2001 07:57:09 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi friends,
	  While reading a source code of pppd i came across a macro
declaration 
like


#define PPPIOCGFLAGS    _IOR('t', 90, int)      /* get configuration flags
*/

I refered to the book called "Linux kernel internals by Beck and others" and
on 
the page 219 (chap implementing a device driver) i found out the line
telling

_IOR(c,d,t)   for commands which write back to the user address space a
value of 
              the C type t

but still i am not being able to understand the macro declaration. Can
someone 
kindly tell me about the _IOW

			thanx	 

*********************************************************************
"UNIX SAYS DO YOUR OWN WAY"
LINUX ENABLES U TO DEFINE "YOUR OWN WAY" 

Choudhury Sarada Prasanna Nanda
Trainee T:24
Motorola India Electronics
TSR Towers, Raj Bhavan Road
Somajiguda,Hyderabad-500082
<cspn_stud@yahoo.com <mailto:cspn_stud@yahoo.com>>
<csaradap@mihy.mot.com <mailto:csaradap@mihy.mot.com>>
Phone:98492-61736 
*********************************************************************


