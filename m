Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264315AbTLESnm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 13:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264313AbTLESmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 13:42:55 -0500
Received: from mail.scitechsoft.com ([63.195.13.67]:65517 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S264315AbTLESmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 13:42:42 -0500
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: "Jason Kingsland" <Jason_Kingsland@hotmail.com>
Date: Fri, 05 Dec 2003 10:44:03 -0800
MIME-Version: 1.0
Subject: Re: Linux GPL and binary module exception clause?
CC: <linux-kernel@vger.kernel.org>
Message-ID: <3FD06173.22096.4801F022@localhost>
In-reply-to: <BAY7-DAV37GkZcFUjvZ0000328a@hotmail.com>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jason Kingsland" <Jason_Kingsland@hotmail.com> wrote:

> Modules are essentially dynamically linked extensions to the GPL
> kernel. In some cases they can be shown to be independent, prior
> works where GPL can reasonably be argued not to apply - which as
> Linus stated earlier on this thread was the original intention of
> allowing binary-only modules. 
> 
> But in most of the more recent cases the driver/module code is
> written specifically for Linux, so it seems more appropriate that
> they would be considered as derived works of the kernel. But those
> various comments from Linus are being taken out of context to
> somehow justify permission for the non-release of source code for
> binary loadable modules. 

I would agree that a module/driver written specifically for Linux would 
fall under the GPL. By extension however, any user program written 
specifically for Linux that does *not* run anywhere else would also fall 
under the GPL. Clearly there are not many programs that fit into this 
category, as most are portable to other platforms. However there are 
clear instances of code that is Linux specific such as the installers 
used by distro vendors to install their version of Linux. By extension if 
Linux specific modules must be GPL, so too must Linux specific 
installation programs. 

Which means all the proprietry installers done by many distro vendors 
that are not GPL would be in violation.

> Linux is not pure GPL, it also has the Linus "user program"
> preamble in copying.txt - that preamble plus other LKML posts from
> Linus are commonly used as justifications for non-disclosure of
> source code to some classes of modules. 

No, Linux is pure GPL. I always thought the same but Linus and others 
have cleared this up in the last few days within this discussion. The pre-
amble at the top of the COPYING file is not legalese and not legally 
binding. It is just Linus' interpretation of the GPL as it applies to 
user programs, and as such is certainly not legally binding.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

