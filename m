Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbVLFWEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbVLFWEs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 17:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbVLFWEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 17:04:48 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:62168
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1030277AbVLFWEr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 17:04:47 -0500
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       rostedt@goodmis.org, johnstul@us.ibm.com, mingo@elte.hu
In-Reply-To: <Pine.LNX.4.61.0512061628050.1610@scrub.home>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0512061628050.1610@scrub.home>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 06 Dec 2005 23:10:56 +0100
Message-Id: <1133907056.16302.79.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

On Tue, 2005-12-06 at 18:32 +0100, Roman Zippel wrote:
> Before I get into a detailed review, I have to asked a question I already 
> asked earlier: are even interested in a discussion about this?

Yes, I am and always was, as long it is on a technical level.

> Slowly I'm asking myself why I should bother, the alternative would be 
> to just continue my own patch set. I don't really want that and Andrew 
> certainly doesn't want to choose between two versions either. So 
> Thomas, please get over yourself and start talking.

I'm interested in working with others and I do that a lot. It depends a
bit on the attitude of the person who wants to do that. I did not have
the feeling that you are interested in working together. Usually people
who want to participate in a project send patches, suggestions or
testing feedback. Your reaction throughout the whole mail threads was
neither cooperative nor appealing to me. I have no problem at all to
accept critizism and help from others, but your attitude of teaching me
how to do my work was just annoying. 

When others have done the hard chores of analysing the underlying
problems and trying to solve them in various ways it is a simple task to
jump in and tell them the big truth of the right solution. Acknowledging
the work of others which led to a maybe imperfect solution in the first
pass and helping in a constructive way to bring it to a better shape is
a different thing.

Sure you can fork off your own project and do what you want if you feel
the urge to do so. We'd prefer to see patches against our queue, but
it's up to you.

I'm replying to the technical points in a different mail.

    tglx


