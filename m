Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbVLGPm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbVLGPm7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 10:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVLGPm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 10:42:59 -0500
Received: from 1-1-3-46a.gml.gbg.bostream.se ([82.182.110.161]:51590 "EHLO
	kotiaho.net") by vger.kernel.org with ESMTP id S1751147AbVLGPm5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 10:42:57 -0500
Date: Wed, 7 Dec 2005 16:42:37 +0100 (CET)
From: "J.O. Aho" <trizt@iname.com>
X-X-Sender: trizt@lai.local.lan
To: Ben Collins <bcollins@ubuntu.com>
cc: "David S. Miller" <davem@davemloft.net>,
       linux-kernel maillist <linux-kernel@vger.kernel.org>,
       sparclinux@vger.kernel.org
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
In-Reply-To: <1133964439.23898.1.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0512071637060.23537@lai.local.lan>
References: <Pine.LNX.4.64.0512060257160.27930@lai.local.lan>
 <20051205.181732.34234732.davem@davemloft.net> <Pine.LNX.4.64.0512061658190.14952@lai.local.lan>
 <20051206.152316.82233251.davem@davemloft.net>
 <Pine.LNX.4.64.0512071203460.8861@localhost.localdomain>
 <1133964439.23898.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2005, Ben Collins wrote:
> On Wed, 2005-12-07 at 12:05 +0100, J.O. Aho wrote:

>> Xorg jumps to VT7, you see a console cursor, "_", at the top left corner
>> and thats it. It's impossible to change back to VT1 (or any other), the
>> only thing that works is to press [stop]-[a] so that you get back to the
>> OBP from where I can reset the machine (resetting by the reset button
>> don't work). It's still possible to ssh to the machine, more and dmesg is
>> possible, but running ps causes the machine to completly lock up, change
>> init mode don't give any affects att all and trying to turn off or kill X
>> results in the same as ps.
>
> Does the dmesg contain any sort of oops?

Nothing else than the "happy guy" error message, the rest is just the 
normal bootup messages like network card drivers been loaded and so on 
(of course those are before the "happy guy")

Sorry for not including the whole dmesg, but been taking eye photos, so 
have quite big difficulties to see anything, including text on 320x200 
screen with big fonts.

-- 
      //Aho

  ------------------------------------------------------------------------
   E-Mail: trizt@iname.com            URL: http://www.kotiaho.net/~trizt/
      ICQ: 13696780
   System: Linux System                        (PPC7447/1000 AMD K7A/2000)
  ------------------------------------------------------------------------
             EU forbids you to send spam without my permission
  ------------------------------------------------------------------------
