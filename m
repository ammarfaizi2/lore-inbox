Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270717AbTG0KJD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 06:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270720AbTG0KJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 06:09:03 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:4496 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S270717AbTG0KJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 06:09:00 -0400
Message-ID: <3F23AC17.4050402@genebrew.com>
Date: Sun, 27 Jul 2003 06:40:23 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
CC: Claas Langbehn <claas@rootdir.de>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.0-test1-ac3: alsa snd_via82xx
References: <20030727091729.GB870@rootdir.de> <20030727101842.GA21556@gentoo.lan>
In-Reply-To: <20030727101842.GA21556@gentoo.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Wirtel wrote:

> I had the same problem of you, and in reading this "manual", you can
> install the module for your sound card, and it works.

That's his point, the driver works as a module but not when compiled 
into the kernel.

-Rahul

