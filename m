Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbWARAgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWARAgb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbWARAgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:36:31 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:2061 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S964918AbWARAg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:36:29 -0500
Date: Tue, 17 Jan 2006 19:32:37 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: John Ronciak <john.ronciak@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>, Stephen Hemminger <shemminger@osdl.org>,
       Vitaly Bordug <vbordug@ru.mvista.com>, jgarzik@pobox.com,
       saw@saw.sw.com.sg, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] remove drivers/net/eepro100.c
Message-ID: <20060118003232.GA28965@tuxdriver.com>
Mail-Followup-To: John Ronciak <john.ronciak@gmail.com>,
	Adrian Bunk <bunk@stusta.de>,
	Stephen Hemminger <shemminger@osdl.org>,
	Vitaly Bordug <vbordug@ru.mvista.com>, jgarzik@pobox.com,
	saw@saw.sw.com.sg, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
References: <20060105181826.GD12313@stusta.de> <20060115161958.07e3c7f1@vitb.dev.rtsoft.ru> <20060115160340.6f8cc7d6@localhost.localdomain> <20060117184834.GD19398@stusta.de> <56a8daef0601171427s75894fid0f8c4f9e2b28e50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56a8daef0601171427s75894fid0f8c4f9e2b28e50@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 02:27:16PM -0800, John Ronciak wrote:

> Another thing is that removal of the driver (or disabling the config)
> will hopefully force the issue in that people with these ARCHs will
> use the e100 and if they have problems we can get them fixed in the
> e100 driver.  At this point nobody seems to be able to define a "real"
> problem other than talking about it.

I vote for eepro100 to come out.
-- 
John W. Linville
linville@tuxdriver.com
