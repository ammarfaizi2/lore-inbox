Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965036AbWARAgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbWARAgq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbWARAgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:36:46 -0500
Received: from mail.dvmed.net ([216.237.124.58]:58288 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965033AbWARAgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:36:44 -0500
Message-ID: <43CD8D72.6040501@pobox.com>
Date: Tue, 17 Jan 2006 19:36:02 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
CC: John Ronciak <john.ronciak@gmail.com>, Adrian Bunk <bunk@stusta.de>,
       Stephen Hemminger <shemminger@osdl.org>,
       Vitaly Bordug <vbordug@ru.mvista.com>, saw@saw.sw.com.sg,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] remove drivers/net/eepro100.c
References: <20060105181826.GD12313@stusta.de> <20060115161958.07e3c7f1@vitb.dev.rtsoft.ru> <20060115160340.6f8cc7d6@localhost.localdomain> <20060117184834.GD19398@stusta.de> <56a8daef0601171427s75894fid0f8c4f9e2b28e50@mail.gmail.com> <20060118003232.GA28965@tuxdriver.com>
In-Reply-To: <20060118003232.GA28965@tuxdriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  John W. Linville wrote: > On Tue, Jan 17, 2006 at
	02:27:16PM -0800, John Ronciak wrote: > > >>Another thing is that
	removal of the driver (or disabling the config) >>will hopefully force
	the issue in that people with these ARCHs will >>use the e100 and if
	they have problems we can get them fixed in the >>e100 driver. At this
	point nobody seems to be able to define a "real" >>problem other than
	talking about it. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:
> On Tue, Jan 17, 2006 at 02:27:16PM -0800, John Ronciak wrote:
> 
> 
>>Another thing is that removal of the driver (or disabling the config)
>>will hopefully force the issue in that people with these ARCHs will
>>use the e100 and if they have problems we can get them fixed in the
>>e100 driver.  At this point nobody seems to be able to define a "real"
>>problem other than talking about it.

Someone should send me a patch that adds eepro100 to the feature-removal 
doc.

	jeff


