Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWF1T7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWF1T7H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 15:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWF1T7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 15:59:07 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37814 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751150AbWF1T66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 15:58:58 -0400
Date: Wed, 28 Jun 2006 21:58:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andreas Jellinghaus <aj@ciphirelabs.com>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       suspend2-devel@lists.suspend2.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: swsusp / suspend2 reliability (was Re: [Suspend2-devel] Re: Suspend2 - Request for review & inclusion in	-mm)
Message-ID: <20060628195844.GD18039@elf.ucw.cz>
References: <200606270147.16501.ncunningham@linuxmail.org> <20060627133321.GB3019@elf.ucw.cz> <44A14D3D.8060003@wasp.net.au> <20060627154130.GA31351@rhlx01.fht-esslingen.de> <20060627222234.GP29199@elf.ucw.cz> <44A24434.5020403@ciphirelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A24434.5020403@ciphirelabs.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2006-06-28 10:56:20, Andreas Jellinghaus wrote:
> swsusp does not work with swap files. suspend2 does.
> 
> so this is an inprovement. improvements are usually merged,
> unless there is a reason not to.

> could the discussion focus on current technical reasons why it
> should not be merged? I somehow get the impression there are
> personal preferences or future development strategies, but neither
> looks like a current technical reason to me, and thus should not
> harm merging or not.

suspend2 uses /proc -- vetoed by Greg. For more reasons, see archives.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
