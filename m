Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268568AbUIXGtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268568AbUIXGtw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 02:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268490AbUIXGpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 02:45:19 -0400
Received: from baikonur.stro.at ([213.239.196.228]:44161 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S268525AbUIXGor
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 02:44:47 -0400
Date: Fri, 24 Sep 2004 08:44:44 +0200
From: maximilian attems <janitor@sternwelten.at>
To: Andrew Morton <akpm@osdl.org>
Cc: Michael Hunold <hunold@linuxtv.org>, linux-kernel@vger.kernel.org,
       linux-dvb-maintainer@linuxtv.org, nacc@us.ibm.com
Subject: Re: [linux-dvb-maintainer] [patch 01/20]  dvb/skystar2: replace schedule_timeout() with msleep()
Message-ID: <20040924064443.GA1932@stro.at>
References: <E1CAapA-0003G3-4b@sputnik> <4153BB10.9010709@linuxtv.org> <20040923232118.66e404f4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040923232118.66e404f4.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2004, Andrew Morton wrote:

> Michael Hunold <hunold@linuxtv.org> wrote:
> >
> > Hi,
> > 
> > On 23.09.2004 23:08, janitor@sternwelten.at wrote:
> > > I would appreciate any comments from the janitor@sternweltens list.
> > 
> > dvb_sleep() is already gone in 2.6.9-rc2-mm2.
> > 

great.
sorry for the noise, had no feedback from dvb.
will keep the needed ones in my tree and resend in 2 weeks to dvb.
 
> yup, none of those dvb patches applied, and I dropped them all.

ok.


--
maks
kernel janitor  	http://janitor.kernelnewbies.org/

