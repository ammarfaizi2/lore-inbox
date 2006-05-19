Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWESPHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWESPHP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 11:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWESPHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 11:07:15 -0400
Received: from main.gmane.org ([80.91.229.2]:36807 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932335AbWESPHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 11:07:14 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Lexington Luthor <lexington.luthor@gmail.com>
Subject: Re: Stealing ur megahurts (no, really)
Date: Fri, 19 May 2006 16:06:22 +0100
Message-ID: <e4kmte$bpc$1@sea.gmane.org>
References: <446D61EE.4010900@comcast.net> <446DA5B0.8020703@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: bb-82-108-13-253.ukonline.co.uk
User-Agent: Thunderbird 1.5.0.2 (Windows/20060302)
In-Reply-To: <446DA5B0.8020703@lumumba.uhasselt.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Panagiotis Issaris wrote:
> An easier way might be to use a system emulator like Qemu.
> You can specify the amount of memory the emulated system has,
> and if you do not use the kernel accelerating module (kqemu)
> it slows down considerably.
> 
> Of course, it would be nicer if you could actually specify performance
> levels and an issue with this approach is that it does not uniformly
> scale down performance: I think IO emulation performance is a lot worse
> then CPU emulation performance (in Qemu).
> 

I have in the past used Bochs to precisely control the exact speed at 
which I run an emulated machine. Though this was for some DOS app which 
insisted on a ~20Mhz CPU, there is no reason this would not work on a 
Linux system emulated by Bochs.

http://bochs.sourceforge.net/

Regards,
LL

