Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbUK0XxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUK0XxP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 18:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbUK0XxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 18:53:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:24502 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261369AbUK0Xw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 18:52:59 -0500
Message-ID: <41A912AD.6030002@osdl.org>
Date: Sat, 27 Nov 2004 15:50:05 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Fred Emmott <mail@fredemmott.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] make root_plug more useful via whitelist
References: <200411272347.15728.mail@fredemmott.co.uk>
In-Reply-To: <200411272347.15728.mail@fredemmott.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fred Emmott wrote:
> patch: http://fredemmott.co.uk/files/rp.patch
> 
> This adds a whitelist of programs such as /bin/login and /sbin/agetty which 
> may be ran as root without the USB device prescent. It also includes my 
> earlier patch to check the USB device's serial number as well as 
> vendor/product.
> 
> This is not meant for inclusion; I'd appreciate comments on anything I've done 
> wrong, and suggestions on how to make it distribution neutral (at the moment 
> it probably only works correctly on slackware) - I'm thinking of adding a 
> security/root_plug_relax/ directory containing files such as "slackware.h" 
> "redhat.h" etc.
> 
> Thanks for your time,
> 

Not Found
The requested URL /files/rp.patch was not found on this server.

-- 
~Randy
