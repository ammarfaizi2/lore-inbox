Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316588AbSGYWUX>; Thu, 25 Jul 2002 18:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316589AbSGYWUX>; Thu, 25 Jul 2002 18:20:23 -0400
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.228]:20681 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S316588AbSGYWUX>; Thu, 25 Jul 2002 18:20:23 -0400
Message-ID: <3D4078C7.4010304@linux.org>
Date: Thu, 25 Jul 2002 18:16:39 -0400
From: John Weber <john.weber@linux.org>
Organization: Linux Online
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020702
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux PCMCIA
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed on the kernel status doc that a revamp of kernel pcmcia is in 
the works.  Can anyone elaborate?

For example, does this mean that 16-bit PCMCIA cards will use hotplug?
Does this mean that 32-bit cards will stop requiring cardmgr to simply 
bind devices to drivers (is it too much to ask that the driver know what 
it drives :)?  The only card of mine (and I have a few 3coms, xircoms, 
lucents) that I think works sanely is my xircom 32-bit cardbus card... 
it would be nice if they all worked that way.  Even though I know that 
this will not be possible for the 16-bit pcmcia cards, IMHO atleast all 
the hotplug devices should use ONE daemon.

I'm curious and excited by the prospect... if there is anything I can do 
to help (even as a newbie I can certainly help change 
unregister/register functions or add any device tables, etc), please let 
me know.

