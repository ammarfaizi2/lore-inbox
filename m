Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264375AbTCXT6U>; Mon, 24 Mar 2003 14:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264381AbTCXT6U>; Mon, 24 Mar 2003 14:58:20 -0500
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:43281 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264375AbTCXT6T>; Mon, 24 Mar 2003 14:58:19 -0500
Date: Mon, 24 Mar 2003 21:05:26 +0100
From: aradorlinux@yahoo.es
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: jgarzik@pobox.com, jbourne@mtroyal.ab.ca, linux-kernel@vger.kernel.org,
       rml@tech9.net, mj@ucw.cz, alan@redhat.com, skraw@ithnet.com,
       szepe@pinerecords.com, arjanv@redhat.com, pavel@ucw.cz
Subject: Re: Ptrace hole / Linux 2.2.25
Message-Id: <20030324210526.3d1bf983.aradorlinux@yahoo.es>
In-Reply-To: <1240000.1048460079@[10.10.2.4]>
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz>
	<200303231938.h2NJcAq14927@devserv.devel.redhat.com>
	<20030323194423.GC14750@atrey.karlin.mff.cuni.cz>
	<1048448838.1486.12.camel@phantasy.awol.org>
	<20030323195606.GA15904@atrey.karlin.mff.cuni.cz>
	<1048450211.1486.19.camel@phantasy.awol.org>
	<402760000.1048451441@[10.10.2.4]>
	<20030323203628.GA16025@atrey.karlin.mff.cuni.cz>
	<Pine.LNX.4.51.0303231410250.17155@skuld.mtroyal.ab.ca>
	<920000.1048456387@[10.10.2.4]>
	<3E7E335C.2050509@pobox.com>
	<1240000.1048460079@[10.10.2.4]>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Mar 2003 14:54:40 -0800
"Martin J. Bligh" <mbligh@aracnet.com> wrote:


> O(1) sched may be a bad example ... how about the fact that mainline VM

I guess alsa is even a better example. It's one of the very few things
that really have sense (IMHO) to have in 2.4.
After all, they're drivers; and many people has to use them to get support.

(I remember in a interview somewhere where Marcelo said he wasn't going to
merge them, but it'd be nice anyway....)


Diego Calleja
