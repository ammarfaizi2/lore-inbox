Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265673AbUBJHQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 02:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265678AbUBJHQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 02:16:56 -0500
Received: from Mail.MNSU.EDU ([134.29.1.12]:55427 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S265673AbUBJHQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 02:16:55 -0500
Message-ID: <40288560.4080603@mnsu.edu>
Date: Tue, 10 Feb 2004 01:16:48 -0600
From: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3-rc2
References: <Pine.LNX.4.58.0402091914040.2128@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402091914040.2128@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please include the patch as in:
http://marc.theaimsgroup.com/?l=linux-kernel&m=107633360814958&w=2

otherwise the Buslogic driver will not compile with gcc-2.95.4


Linus Torvalds wrote:

>Uhhuh. There was a bit more pending, so here's a -rc2. Now please calm 
>down, I'd like this to have some time to stabilize..
>
>The rc1->rc2 changes are mostly driver side stuff: PnP update, USB, ACPI,
>IRDA, i2c, hotplug-PCI and netdrivers etc. But there's a NFSv4 update and
>soem XFS fixes there too.
>
>And some ARM and sparc updates.
>
>  
>
