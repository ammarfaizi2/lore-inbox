Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWAYR62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWAYR62 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 12:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWAYR62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 12:58:28 -0500
Received: from seanodes.co.fr.clara.net ([212.43.220.11]:37795 "EHLO
	seanodes.co.fr.clara.net") by vger.kernel.org with ESMTP
	id S1750852AbWAYR61 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 12:58:27 -0500
Message-ID: <43D7BC3B.8000701@enix.org>
Date: Wed, 25 Jan 2006 18:58:19 +0100
From: Thomas Petazzoni <thomas.petazzoni@enix.org>
User-Agent: Mozilla Thunderbird 1.0.6-7.2.20060mdk (X11/20050322)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: sjackman@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Replaying a list of blocks into the cache (BootCache)
References: <5yWak-99-39@gated-at.bofh.it>
In-Reply-To: <5yWak-99-39@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[ Sorry, I'm reading linux-kernel through the newsgroup, so my reply may
not contain the correct references, and may break the threading. ]

Shaun Jackman a écrit :

> This made me think of the OS X BootCache feature, which saves the list
> of disk  blocks accessed during the boot sequence and replays that
> list on the next boot. Is there anything like this in Linux?

This has been discussed 2 years ago on KernelTrap:
http://kerneltrap.org/node/2157

I don't know if there have been further developments in this area.

Sincerly,

Thomas
-- 
Thomas Petazzoni, thomas.petazzoni@enix.org

