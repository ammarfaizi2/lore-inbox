Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTGMOgy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 10:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268843AbTGMOgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 10:36:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45740 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263152AbTGMOgx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 10:36:53 -0400
Message-ID: <3F1171E3.3060303@pobox.com>
Date: Sun, 13 Jul 2003 10:51:15 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Shih <alan@storlinksemi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: TCP IP Offloading Interface
References: <ODEIIOAOPGGCDIKEOPILCEMBCMAA.alan@storlinksemi.com>
In-Reply-To: <ODEIIOAOPGGCDIKEOPILCEMBCMAA.alan@storlinksemi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Shih wrote:
> Has anyone worked on a standard interface between TOE and Linux? (ie.
> something like Trapeze/Myrinet's GMS?)
> 
> Or TOE is a forbidden discussion?  Any effort in making Linux the OS for TOE
> at all even though Linux is a little too heavy for it?


I do not forsee there _ever_ being a TOE interface for Linux.

It's not a forbidden discussion, but, the networking developers tend to 
ignore people who mention TOE because it's been discussed to death, and 
no evidence has ever been presented to prove it has advantages where it 
matters, and it has significant _dis_advantages from the get-go.

I really should write an LKML FAQ entry for TOE.

	Jeff



