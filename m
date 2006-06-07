Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWFGQVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWFGQVU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 12:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWFGQVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 12:21:20 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:55819 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932289AbWFGQVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 12:21:19 -0400
Message-ID: <4486FD2F.8040205@gentoo.org>
Date: Wed, 07 Jun 2006 17:22:07 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Jiri Benc <jbenc@suse.cz>, linville@tuxdriver.com,
       kernel list <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: [patch] workaround zd1201 interference problem
References: <20060607140045.GB1936@elf.ucw.cz> <20060607160828.0045e7f5@griffin.suse.cz> <20060607141536.GD1936@elf.ucw.cz>
In-Reply-To: <20060607141536.GD1936@elf.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Well, I'll try _enable() alone, but it seems to me that _enable()
> command is needed to initialize radio properly. I do not think we can
> get much further without firmware sources...

If you can formulate a proper and technical description of the issue 
(and exactly what is needed to workaround it), I can contact ZyDAS for 
you. They have been very helpful with ZD1211.

Daniel
