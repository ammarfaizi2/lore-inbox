Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbUK2O2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbUK2O2T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 09:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbUK2O2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 09:28:19 -0500
Received: from h66-38-154-67.gtcust.grouptelecom.net ([66.38.154.67]:47563
	"EHLO pbl.ca") by vger.kernel.org with ESMTP id S261261AbUK2O2Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 09:28:16 -0500
Message-ID: <41AB31FD.2030501@pbl.ca>
Date: Mon, 29 Nov 2004 08:28:13 -0600
From: Aleksandar Milivojevic <amilivojevic@pbl.ca>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041020)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: network console
References: <41A78D0A.5060308@pbl.ca> <41A7E8AD.9050405@g-house.de>
In-Reply-To: <41A7E8AD.9050405@g-house.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Kujau wrote:
> Aleksandar Milivojevic schrieb:
> 
>>Has anybody attempted to implement console on network interface (with or
> 
> 
> please read Documentation/networking/netconsole.txt.

Not exactly what I had in mind, but having kernel printk messages sent 
to remote host will be helpfull too.  What I had in mind was actually 
having two-way fully functional network console (something I could also 
use to log onto the machine, say if I screw up firewall settings and 
lock myself out).


-- 
Aleksandar Milivojevic <amilivojevic@pbl.ca>    Pollard Banknote Limited
Systems Administrator                           1499 Buffalo Place
Tel: (204) 474-2323 ext 276                     Winnipeg, MB  R3T 1L7
