Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265722AbUFSNuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265722AbUFSNuB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 09:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265725AbUFSNuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 09:50:00 -0400
Received: from main.gmane.org ([80.91.224.249]:56041 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265722AbUFSNtn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 09:49:43 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Gabriel Lavoie <exibis@hotmail.com>
Subject: Re: linux 2.6.6 and keyboard freezes
Date: Sat, 19 Jun 2004 09:49:36 -0400
Message-ID: <cb1g9g$fik$1@sea.gmane.org>
References: <20040603161748.141C61DC040@bromo.msbb.uc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: modemcable185.89-201-24.mc.videotron.ca
User-Agent: Mozilla Thunderbird 0.7 (Windows/20040616)
X-Accept-Language: en-us, en
In-Reply-To: <20040603161748.141C61DC040@bromo.msbb.uc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The same problem appeared here with a laptop keyboard, on a Toshiba 
Satellite A20. No problem with 2.5.5.

Jack Howarth wrote:
>      Is anyone else seeing this behavior? On Fedora Core 2 using the
> their kernel-smp-2.6.6-1.403 and kernel-smp-2.6.6-1.406 kernels I 
> am seeing a problem with a PS/2 Logitech keyboard becoming
> non-functional after overnight. In particular the keyboard is
> initially usable after the machine is woken the next morning
> under X windows. Shortly afterwards (~15 minutes) the keyboard
> stops responding. The PS/2 mouse still works however and one
> can log out of the X windows session to restart the X server.
> This however doesn't bring back the keyboard. Also unplugging
> and replugging the keyboard doesn't help. Only a full reboot
> will restore the keyboard to working condition. There is no
> errors appearing in /var/log/messages that indicate any 
> errors related to the keyboard. I have heard from at least
> one other Fedora user who has seen the same thing under Core 2.
> Is this perhaps related to acpi somehow and how can I work
> around it since rebooting everyday is unacceptable.
>                         Jack Howarth

