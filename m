Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267170AbUHYLwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267170AbUHYLwc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 07:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267164AbUHYLwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 07:52:32 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:1424 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S267195AbUHYLvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 07:51:51 -0400
X-Sender-Authentication: net64
Date: Wed, 25 Aug 2004 13:51:49 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD/DVD record
Message-Id: <20040825135149.2166f4a4.skraw@ithnet.com>
In-Reply-To: <cgdpdk$l9i$1@gatekeeper.tmr.com>
References: <4125B539.6040402@hist.no>
	<4125B539.6040402@hist.no>
	<4125BA56.1060307@wiggly.org>
	<cgdpdk$l9i$1@gatekeeper.tmr.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2004 18:07:09 -0400
Bill Davidsen <davidsen@tmr.com> wrote:

> > Hat trick on the Good Point(tm) front. Agreed!
> > 
> > Well then I may go and look into cd recording then...hmm...
> 
> I hate to say it, but why reinvent the wheel? I'm sure that if Jorg 
> doesn't support new technology there will be a project, either on 
> sourceforge or freestanding, to create OpenCDburn or some such. It would 
> be very hard to find someone as technically good as Jorg in this area, 
> [...]

Actually this is only FUD spread by Joerg. He is definitely not the only man on
this planet knowing how to program CD/DVD burning equipment.

Generally cdrecord has one big deficiency, which obviously was intended:
it does not allow medium skilled programmers from drive _vendors_ to add
support for their latest hardware easily. Everyone has to beg Joerg, which
obviously increased his ego dramatically over the years.
It would be a lot better to start off a new project where vendors (or anybody
with skill and will) can contribute more easily, i.e. something that is truely
_open_.

Regards,
Stephan



