Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271687AbTGXPTP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 11:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271691AbTGXPTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 11:19:15 -0400
Received: from ns.tasking.nl ([195.193.207.2]:58887 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S271687AbTGXPRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 11:17:44 -0400
Message-ID: <3F1FFBCA.8050703@_netscape_._net_>
Date: Thu, 24 Jul 2003 17:31:22 +0200
From: David Zaffiro <davzaffiro@tasking.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021220 Debian/1.2.1-3
X-Accept-Language: nl, en-us
MIME-Version: 1.0
To: alexander.riesen@synopsys.COM
CC: linux-kernel@vger.kernel.org
Subject: Re: using defaults from older kernels
References: <20030724134929.GJ13611@Synopsys.COM>
In-Reply-To: <20030724134929.GJ13611@Synopsys.COM>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why not use `make oldconfig`?

Alex Riesen wrote:
> Probably not very good idea.
> (I decided to retreat to "make defconfig" after it).

