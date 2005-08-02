Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbVHBQJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVHBQJb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 12:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVHBP7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 11:59:30 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:56970 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261621AbVHBP6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 11:58:19 -0400
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
From: Lee Revell <rlrevell@joe-job.com>
To: James Bruce <bruce@andrew.cmu.edu>
Cc: sclark46@earthlink.net, linux-kernel@vger.kernel.org
In-Reply-To: <42EF947E.1070600@andrew.cmu.edu>
References: <20050730195116.GB9188@elf.ucw.cz>
	 <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz>
	 <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz>
	 <42ED4CCF.6020803@andrew.cmu.edu> <20050731224752.GC27580@elf.ucw.cz>
	 <1122852234.13000.27.camel@mindpipe>
	 <20050801074447.GJ9841@khan.acc.umu.se> <42EE4B4A.80602@andrew.cmu.edu>
	 <20050801204245.GC17258@thunk.org> <42EEFB9B.10508@andrew.cmu.edu>
	 <42EF70BD.7070804@earthlink.net>  <42EF947E.1070600@andrew.cmu.edu>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 11:58:15 -0400
Message-Id: <1122998296.11253.25.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-02 at 11:42 -0400, James Bruce wrote:
> I do like saving power, which is why I run cpu frequency scaling on 
> every machine I have that supports it.

My Athlon XP desktop doesn't support frequency scaling but has working
ACPI C-states (at least under Windows) so will run as cool as 31C when
idle (with the CPUIdle utility).  Most of the heat comes from the hard
drives anyway, but that's a different story.

This seems pretty cool to me, how much more power does frequency scaling
save over that, assuming you suspend after 5-10 minutes of inactivity
anyway?

Lee

