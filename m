Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265182AbTLFPCl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 10:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265188AbTLFPCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 10:02:40 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:13326 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S265182AbTLFPCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 10:02:40 -0500
Message-ID: <3FD1EF8E.9010401@dcrdev.demon.co.uk>
Date: Sat, 06 Dec 2003 15:02:38 +0000
From: Dan Creswell <dan@dcrdev.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: i8042 problem on -test11
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm, this problem seems to go away if I turn off CONFIG_HIGHMEM64G.

I had it turned on because my BIOS has the ability to map memory 
obscured by PCI devices above the 4G boundary - nevermind - not that 
much of a loss.

Cheers,

Dan.


