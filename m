Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265101AbUEYVcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265101AbUEYVcM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 17:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265099AbUEYVcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 17:32:12 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:12807 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S265101AbUEYVcI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 17:32:08 -0400
Date: Tue, 25 May 2004 23:32:05 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Bad X-performance on 2.6.6 & 2.6.7-rc1 on x86-64
Message-ID: <20040525213205.GB28395@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1ZqbC-5Gl-13@gated-at.bofh.it> <m3r7t9d3li.fsf@averell.firstfloor.org> <20040525122659.395783f4@highlander.Home.LAN> <20040525123636.GA13817@colin2.muc.de> <1085520021.1393.4168.camel@duergar>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1085520021.1393.4168.camel@duergar>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 05:20:22PM -0400, Stan Bubrouski wrote:
> I can confirm that xine with alsa-mmap option set does cuase strange
> behaviour, though I notice it mostly as audio and video getting out of
> sync when playing videos.  I've noticed this behaviour since I started
> doing weekly xine CVS builds.  I've never bothered reporting it however,
> I just turned off the option... which leads me to my question, what is
> the advantage of using alsa-mmap in an app if it is used correctly?

 Could for completness test mplayer with alsa-mmap, too? 
Its '-ao alsa:mmap' option.

-- 
Tomasz Torcz                        To co nierealne - tutaj jest normalne.
zdzichu@irc.-nie.spam-.pl          Ziomale na ¿ycie maj± tu patenty specjalne.

