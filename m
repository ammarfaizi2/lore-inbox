Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270927AbTG0SbR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 14:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270928AbTG0SbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 14:31:17 -0400
Received: from oak.sktc.net ([64.71.97.14]:62957 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id S270927AbTG0SbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 14:31:16 -0400
Message-ID: <3F241DC0.7080408@sktc.net>
Date: Sun, 27 Jul 2003 13:45:20 -0500
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Adrian Bunk <bunk@fs.tum.de>, "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: time for some drivers to be removed?
References: <Pine.LNX.4.53.0307240817520.19533@localhost.localdomain>	 <20030727153118.GP22218@fs.tum.de>  <3F23F6EB.7070502@sktc.net> <1059324018.13442.0.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1059324018.13442.0.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> We've had one for years. Its CONFIG_OBSOLETE, its even used in 2.6test

I would disagree - OBSOLETE to me means just that - that module is 
obsolete. Minix FS, OSS (as opposed to ALSA), and the old non-SCSI, 
non-IDE HD interfaces would be OBSOLETE.

Besides, I have seen cases where Firewire modules wouldn't build for 
some period of time - would you deem them OBSOLETE?

