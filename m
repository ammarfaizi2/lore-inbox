Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUCJI1S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 03:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbUCJI1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 03:27:18 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:61448 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262547AbUCJI1O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 03:27:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Dax Kelson <dax@gurulabs.com>,
       James Ketrenos <jketreno@linux.co.intel.com>
Subject: Re: [Announce] Intel PRO/Wireless 2100 802.11b driver
Date: Wed, 10 Mar 2004 10:15:19 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <404E27E6.40200@linux.co.intel.com> <1078866774.2925.15.camel@mentor.gurulabs.com>
In-Reply-To: <1078866774.2925.15.camel@mentor.gurulabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200403101015.19506.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 March 2004 23:12, Dax Kelson wrote:
> On Tue, 2004-03-09 at 13:24, James Ketrenos wrote:
> > I am pleased to announce the launch of an open source development project
> > for the Intel PRO/Wireless 2100 miniPCI network adapter. The project has
> > been created and is hosted at http://ipw2100.sf.net.
>
> I applaud Intel for starting to plug this major hole. This looks
> promising.
>
> I took a look at the website and see the GPL driver and the closed
> firmware.
>
> Is it is really *firmware*, in that it loads and executes purely within
> the Intel PRO/Wireless 2100 itself and not in the linux kernel on the
> main CPU? If so, bravo!

*FLAME ALERT*
/me is slowly getting mad about his prism54 11g hardware
and its firmware, with neither firmware authors nor documentation
for this pile of silicon crap nowhere in sight

What's so cool about having binary firmware? Bugs are bugs,
and you won't be able to even see bugs, less fix, in it.
I don't like being at the mercy of firmware authors.
--
vda
