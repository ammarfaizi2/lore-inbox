Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272560AbTG1BH3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272559AbTG1ADu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:03:50 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272734AbTG0W6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:58:43 -0400
Subject: Re: time for some drivers to be removed?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David D. Hagood" <wowbagger@sktc.net>
Cc: Adrian Bunk <bunk@fs.tum.de>, "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F241DC0.7080408@sktc.net>
References: <Pine.LNX.4.53.0307240817520.19533@localhost.localdomain>
	 <20030727153118.GP22218@fs.tum.de>  <3F23F6EB.7070502@sktc.net>
	 <1059324018.13442.0.camel@dhcp22.swansea.linux.org.uk>
	 <3F241DC0.7080408@sktc.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059338443.13875.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Jul 2003 21:40:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-07-27 at 19:45, David D. Hagood wrote:
> I would disagree - OBSOLETE to me means just that - that module is 
> obsolete. Minix FS, OSS (as opposed to ALSA), and the old non-SCSI, 
> non-IDE HD interfaces would be OBSOLETE.
> 
> Besides, I have seen cases where Firewire modules wouldn't build for 
> some period of time - would you deem them OBSOLETE?

The code in question is obsolete if it wont build because its out of date
with respect to the core. The point I was trying to make is we have a
definition (have had since 2.2) and actively use it. So there is nothing
to invent here

