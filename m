Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262323AbVC2Ffi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbVC2Ffi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 00:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbVC2Ffh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 00:35:37 -0500
Received: from quark.didntduck.org ([69.55.226.66]:26008 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S262323AbVC2Ffc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 00:35:32 -0500
Message-ID: <4248E9A6.4070302@didntduck.org>
Date: Tue, 29 Mar 2005 00:37:42 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0-5 (X11/20050308)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aaron Gyes <floam@sh.nu>
CC: Greg KH <greg@kroah.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
References: <1111886147.1495.3.camel@localhost>	 <490243b66dc7c3f592df7a7d0769dcb7@mac.com>	 <20050327181221.GB14502@kroah.com> <1112058277.14563.4.camel@localhost>	 <20050329033350.GA6990@kroah.com> <1112070511.32594.4.camel@localhost>	 <20050329044533.GG7362@kroah.com> <1112074170.3358.0.camel@localhost>
In-Reply-To: <1112074170.3358.0.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Gyes wrote:
> On Mon, 2005-03-28 at 20:45 -0800, Greg KH wrote:
> 
> 
>>What do you mean by "static"?  Something that persists over a reboot?
>>Or after the device is removed?
> 
> 
> Forgot to clarify. Create a node for something that's not in sysfs, with
> udev.

At least in Fedora, /etc/udev/makedevices.d or /etc/udev/devices.

--
				Brian Gerst
