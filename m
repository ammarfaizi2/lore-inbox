Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbTDWTjI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbTDWTiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:38:13 -0400
Received: from lakemtao02.cox.net ([68.1.17.243]:64943 "EHLO
	lakemtao02.cox.net") by vger.kernel.org with ESMTP id S263568AbTDWThg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:37:36 -0400
Message-ID: <3EA6EE47.4000801@cox.net>
Date: Wed, 23 Apr 2003 14:49:27 -0500
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nils Holland <nils@ravishing.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.4.21-rc1] USB Trackball broken
References: <3EA6C558.5040004@cox.net> <200304232134.42349.nils@ravishing.de>
In-Reply-To: <200304232134.42349.nils@ravishing.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nils Holland wrote:
> On Wednesday 23 April 2003 18:54, David van Hoose wrote:
> 
> 
>>I am running RedHat 9. Trackball is detected and works when using the
>>stock 2.4.20-9 kernel that RedHat provided.
>>
>>With 2.4.21-rc1, I have included the USB and input devices in the
>>kernel, as modules, and as various combinations in between. My USB
>>Logitech Trackball shows up as being detected and setup, but it doesn't
>>work.
> 
> 
> I'm using a Logitech Cordless TrackMan here, and this works fine with 
> 2.4.21-rc1. I don't know which trackball you have, but the Logitech input 
> devices all seem to be using more or less the same receiver, and this is what 
> the problem would be about.
> 
> Anyway, if not done already, I would suggest that you plug the trackball right 
> into one of the computer's USB ports and not into an external hub to see if 
> that makes a difference.

I have a Logitech Cordless Optical Trackman. It detects as a Logitech 
Cordless Receiver. My motherboard is an Asus P4S8X. It has the 
SiS648/SiS963 chipsets. I'm not using an external hub. I'm using the 
ports on my motherboard. I've tried using all 6 USB ports I have, but I 
get the same thing; detection and no input.

Regards,
David

