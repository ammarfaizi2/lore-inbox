Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932738AbWEXNWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932738AbWEXNWf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 09:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932739AbWEXNWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 09:22:35 -0400
Received: from ns.suse.de ([195.135.220.2]:57573 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932738AbWEXNWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 09:22:34 -0400
Date: Wed, 24 May 2006 15:17:07 +0200
From: Stefan Seyfried <seife@suse.de>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Manu Abraham <abraham.manu@gmail.com>,
       linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, "D. Hazelton" <dhazelton@enter.net>,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060524131707.GA20628@suse.de>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <44700ACC.8070207@gmail.com> <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com> <200605230048.14708.dhazelton@enter.net> <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com> <E1Fifom-0003qk-00@chiark.greenend.org.uk> <9e4733910605231638t4da71284oa37b66a88c60cf8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e4733910605231638t4da71284oa37b66a88c60cf8a@mail.gmail.com>
X-Operating-System: SUSE LINUX 10.1 (i586), Kernel 2.6.16.13-4-default
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2006 at 07:38:40PM -0400, Jon Smirl wrote:
> On 5/23/06, Matthew Garrett <mgarrett@chiark.greenend.org.uk> wrote:

> 1) I didn't put a lot of detail into the line item but you only need
> to use the ROM to reset secondary cards on x86 architectures. Primary
> cards are always initialized by the system BIOS so you don't need to
> run their ROM on boot. I think the only way to get a secondary card
> into a laptop is through a

Docking station.
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen
