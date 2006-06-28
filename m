Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161012AbWF1I6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbWF1I6I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 04:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161240AbWF1I6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 04:58:07 -0400
Received: from mx1.ciphirelabs.net ([217.72.114.64]:59307 "EHLO
	mx1.ciphirelabs.net") by vger.kernel.org with ESMTP
	id S1161012AbWF1I6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 04:58:05 -0400
Message-ID: <44A24434.5020403@ciphirelabs.com>
Date: Wed, 28 Jun 2006 10:56:20 +0200
From: Andreas Jellinghaus <aj@ciphirelabs.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       suspend2-devel@lists.suspend2.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: swsusp / suspend2 reliability (was Re: [Suspend2-devel] Re: Suspend2
 - Request for review & inclusion in	-mm)
References: <200606270147.16501.ncunningham@linuxmail.org>	<20060627133321.GB3019@elf.ucw.cz> <44A14D3D.8060003@wasp.net.au>	<20060627154130.GA31351@rhlx01.fht-esslingen.de> <20060627222234.GP29199@elf.ucw.cz>
In-Reply-To: <20060627222234.GP29199@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Ciphire-Security: plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

swsusp does not work with swap files. suspend2 does.

so this is an inprovement. improvements are usually merged,
unless there is a reason not to.

could the discussion focus on current technical reasons why it
should not be merged? I somehow get the impression there are
personal preferences or future development strategies, but neither
looks like a current technical reason to me, and thus should not
harm merging or not.

Regards, Andreas
