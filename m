Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbVL0Esi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbVL0Esi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 23:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbVL0Esi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 23:48:38 -0500
Received: from stinky.trash.net ([213.144.137.162]:43426 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S932219AbVL0Esi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 23:48:38 -0500
Message-ID: <43B0C788.3010803@trash.net>
Date: Tue, 27 Dec 2005 05:48:08 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gcoady@gmail.com
CC: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       torvalds@osdl.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: Linux 2.6.14.5
References: <20051227005327.GA21786@kroah.com> <32b1r156pu7much2m94ajva2bmcs4mpcag@4ax.com>
In-Reply-To: <32b1r156pu7much2m94ajva2bmcs4mpcag@4ax.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady wrote:
> netfilter is broken compared to 2.6.15-rc7 (first 2.6 kernel tested 
> on this box) or 2.4.32 :(  Same ruleset as used for months.
> 
> Fails to recognise named chains with a useless error message:
> 
> "iptables: No chain/target/match by that name"

Please give an example of a failing command.
