Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262699AbUKXPmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbUKXPmB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 10:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbUKXPjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 10:39:39 -0500
Received: from [195.23.16.24] ([195.23.16.24]:52148 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262765AbUKXPjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 10:39:11 -0500
Message-ID: <41A49BB0.60002@grupopie.com>
Date: Wed, 24 Nov 2004 14:33:20 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Fedin <sonic_amiga@rambler.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Licensing question
References: <20041124140433.1d9d1022.sonic_amiga@rambler.ru>
In-Reply-To: <20041124140433.1d9d1022.sonic_amiga@rambler.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.18; VDF: 6.28.0.88; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Fedin wrote:
>  Hello!
>  I'm a member of AROS team (http://www.aros.org) and i'd like to ask for a permission to use parts of Linux source code (small parts) in developing this system. It is licensed under APL (http://www.aros.org/license.html) so i need a permission. I don't know where to ask for it so i ask here.
>  Currently i use a little part of ide-cd driver and its includes.
> 

 From your license page, I can see that the license is based on the MPL 
(Mozilla public license). If you check:

http://www.gnu.org/philosophy/license-list.html

the MPL is listed as a GPL incompatible license.

This means that either the APL solves the issues of the MPL so that it 
is GPL compatible, or you have to ask the original authors permission to 
use their code (which is usually complicated because there are usually a 
lot of them...)

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
