Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbTJMQBw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 12:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbTJMQBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 12:01:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:63191 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261798AbTJMQBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 12:01:52 -0400
Date: Mon, 13 Oct 2003 09:01:08 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       "David S. Miller" <davem@redhat.com>,
       Michael Hunold <hunold@convergence.de>, linux-dvb@linuxtv.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/14] LinuxTV.org DVB driver update
Message-Id: <20031013090108.3aa8c464.shemminger@osdl.org>
In-Reply-To: <20031012110846.GA1677@mars.ravnborg.org>
References: <20031011105320.1c9d46db.davem@redhat.com>
	<Pine.GSO.4.21.0310121115260.27309-100000@starflower.sonytel.be>
	<20031012110846.GA1677@mars.ravnborg.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.5claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think root cause of the problem is that dvb was only just been added
to the MAINTAINERS file so the patch got lost when I sent to closet
match was the video lists. It was kind of orphan thing since it crossed
both networking and DVB.

Do you need any help in reinserting it?
