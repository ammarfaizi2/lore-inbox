Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVADP0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVADP0m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 10:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVADP0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 10:26:42 -0500
Received: from fire.osdl.org ([65.172.181.4]:48285 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261675AbVADP0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 10:26:41 -0500
Message-ID: <41DAB4EC.2070309@osdl.org>
Date: Tue, 04 Jan 2005 07:23:24 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: ak@suse.de
Subject: Re: [PATCH] x86_64: Add reboot=force
References: <200501040623.j046N1Sf011351@hera.kernel.org>
In-Reply-To: <200501040623.j046N1Sf011351@hera.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.2136.3.75, 2005/01/03 20:44:39-08:00, ak@suse.de
> 
> 	[PATCH] x86_64: Add reboot=force
> 	
> 	Add reboot=force
> 	
> 	reboot=force doesn't wait for any other CPUs on reboot.  This is useful when
> 	you really need a system to reboot on its own.

Why only for x86_64 ?

-- 
~Randy
