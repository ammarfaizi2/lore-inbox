Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268497AbUIXG1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268497AbUIXG1a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 02:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268496AbUIXG1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 02:27:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:33004 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268484AbUIXGYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 02:24:12 -0400
Date: Thu, 23 Sep 2004 23:21:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Hunold <hunold@linuxtv.org>
Cc: janitor@sternwelten.at, akpm@digeo.com, linux-kernel@vger.kernel.org,
       linux-dvb-maintainer@linuxtv.org, nacc@us.ibm.com
Subject: Re: [linux-dvb-maintainer] [patch 01/20]  dvb/skystar2: replace
 schedule_timeout() with msleep()
Message-Id: <20040923232118.66e404f4.akpm@osdl.org>
In-Reply-To: <4153BB10.9010709@linuxtv.org>
References: <E1CAapA-0003G3-4b@sputnik>
	<4153BB10.9010709@linuxtv.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Hunold <hunold@linuxtv.org> wrote:
>
> Hi,
> 
> On 23.09.2004 23:08, janitor@sternwelten.at wrote:
> > I would appreciate any comments from the janitor@sternweltens list.
> 
> dvb_sleep() is already gone in 2.6.9-rc2-mm2.
> 

yup, none of those dvb patches applied, and I dropped them all.
