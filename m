Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965882AbWKEOfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965882AbWKEOfE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 09:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965881AbWKEOfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 09:35:01 -0500
Received: from stinky.trash.net ([213.144.137.162]:19086 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S965882AbWKEOfA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 09:35:00 -0500
Message-ID: <454DF690.2010405@trash.net>
Date: Sun, 05 Nov 2006 15:34:56 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@redhat.com>, netdev@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH 1/1] Net: kconfig, correct traffic shaper
References: <453BA26D.9010504@trash.net>, <43123154321532@wsc.cz> <1202725131414221392@wsc.cz>
In-Reply-To: <1202725131414221392@wsc.cz>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Ok, thanks for comments. Here it comes, please (n)ack it:
> 
> --
> 
> kconfig, correct traffic shaper
> 
> As Patrick McHardy <kaber@trash.net> suggested, Traffic Shaper is
> now obsolete and alternative to it is no longer CBQ, since its problems with
> virtual devices, alter Kconfig text to reflect this -- put a link to the
> traffic schedulers as a whole.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> Cc: Alan Cox <alan@redhat.com>
> Cc: Patrick McHardy <kaber@trash.net>

Looks good, thanks.
