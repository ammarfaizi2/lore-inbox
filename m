Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVHBOMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVHBOMJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 10:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVHBOJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 10:09:37 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:48617 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261544AbVHBOI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 10:08:29 -0400
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
From: Lee Revell <rlrevell@joe-job.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: James Bruce <bruce@andrew.cmu.edu>, David Weinehall <tao@acc.umu.se>,
       Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050802112304.GA1308@elf.ucw.cz>
References: <20050730195116.GB9188@elf.ucw.cz>
	 <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz>
	 <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz>
	 <42ED4CCF.6020803@andrew.cmu.edu> <20050731224752.GC27580@elf.ucw.cz>
	 <1122852234.13000.27.camel@mindpipe>
	 <20050801074447.GJ9841@khan.acc.umu.se> <42EE4B4A.80602@andrew.cmu.edu>
	 <20050802112304.GA1308@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 10:08:27 -0400
Message-Id: <1122991707.5490.32.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-02 at 13:23 +0200, Pavel Machek wrote:
> As I said, I do not care about default value. And you should not care,
> too, since distros are likely to pick their own defaults.

If the default value does not matter then the default should remain at
1000 so as to not violate the principle of least surprise for people who
run "make oldconfig".  Why is this so hard for people to understand?

Lee

