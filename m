Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbUC0Dh5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 22:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUC0Dh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 22:37:57 -0500
Received: from 69-150-147-130.ded.swbell.net ([69.150.147.130]:54679 "HELO
	arumekun.no-ip.com") by vger.kernel.org with SMTP id S261667AbUC0Dh4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 22:37:56 -0500
From: Luke-Jr <luke-jr@artcena.com>
To: swsusp-devel@lists.sourceforge.net, ncunningham@users.sourceforge.net
Subject: Re: -nice tree [was Re: [Swsusp-devel] Re: swsusp problems =?iso-8859-1?q?=5Bwas=09Re=3A_Your_opinion_on_the?= merge?]]
Date: Sat, 27 Mar 2004 03:37:48 +0000
User-Agent: KMail/1.6.1
Cc: Pavel Machek <pavel@ucw.cz>, Michael Frank <mhf@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040323233228.GK364@elf.ucw.cz> <20040326222234.GE9491@elf.ucw.cz> <1080353285.9264.3.camel@calvin.wpcb.org.au>
In-Reply-To: <1080353285.9264.3.camel@calvin.wpcb.org.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403270337.48704.luke-jr@artcena.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 March 2004 02:08 am, Nigel Cunningham wrote:
> On Sat, 2004-03-27 at 10:22, Pavel Machek wrote:
> > You are right, that would be ugly. How is encryption supposed to work,
> > kernel asks you to type in a key?
>
> I haven't thought about the specifics there. Perhaps the plugin prompts
> for one, or perhaps it takes a lilo parameter? 
The only purpose I can think of for encryption would be so someone can't grab 
the HD and boot it on another PC or read the image directly.
Unless I'm missing something, that would imply that the key would need to be 
generated from a hardware profile (only creatable by root) somehow to 
restrict its readability to that one system.
