Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbTBBSTx>; Sun, 2 Feb 2003 13:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265469AbTBBSTx>; Sun, 2 Feb 2003 13:19:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40210 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265446AbTBBSTw>;
	Sun, 2 Feb 2003 13:19:52 -0500
Message-ID: <3E3D6367.9090907@pobox.com>
Date: Sun, 02 Feb 2003 13:28:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: 2.4.21-pre4: tg3 driver problems with shared interrupts
References: <20030202161837.010bed14.skraw@ithnet.com>	<3E3D4C08.2030300@pobox.com> <20030202185205.261a45ce.skraw@ithnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:
> On Sun, 02 Feb 2003 11:49:12 -0500
> Jeff Garzik <jgarzik@pobox.com> wrote:
>>Can you try two things?
>>
>>1) 2.4.21-pre4 + tg3 v1.4
> 
> 
> Ok. With the latest version you sent I got it compiled and working. As far as I
> can tell from short tests it looks good (eth2 is tg3):

cool beans, thanks!


> To make sure I will let it stress-test overnight and send you the results in
> about 15 hours from now on. If everything does fine I will redo with ide2,ide3
> on same interrupt, too. Just to see what happens with these Promise things...


great.

though who knows with the Promise stuff... :)  I hope it's not their 
binary-only junk...

	Jeff




