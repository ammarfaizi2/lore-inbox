Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932591AbVKXD0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbVKXD0w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 22:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932619AbVKXD0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 22:26:52 -0500
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:39256 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932591AbVKXD0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 22:26:51 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: Mouse issues in -mm
Date: Wed, 23 Nov 2005 22:26:43 -0500
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, Marc Koschewski <marc@osknowledge.org>,
       linux-kernel@vger.kernel.org, Harald Welte <laforge@netfilter.org>,
       netdev@vger.kernel.org
References: <20051123033550.00d6a6e8.akpm@osdl.org> <20051123113854.07fca702.akpm@osdl.org> <4385202E.70404@tuxrocks.com>
In-Reply-To: <4385202E.70404@tuxrocks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511232226.44459.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 November 2005 21:06, Frank Sorenson wrote:
> Andrew Morton wrote:
> > Marc Koschewski <marc@osknowledge.org> wrote:
> >>Just booted into 2.6.15-rc2-mm1. The 'mouse problem' (as reported earlier) still
> >>persists,
> >
> > You'l probably need to re-report the mouse problem if the previous report
> > didn't get any action.
> 
> I'm not certain whether this is the same 'mouse problem', but I'll
> report the mouse problems I've been seeing.  In the past several -mm
> kernels, my touchpad has initially worked at boot, but 'tapping' has
> stopped working at some point later (with no obvious kernel messages).
> 
> I've experienced this problem at least with 2.6.15-rc1-mm2 and
> 2.6.15-rc2-mm1, and reverting
> input-attempt-to-re-synchronize-mouse-every-5-seconds.patch gives a
> kernel without the touchpad problems.
>

What kind of touchpad do you have? Could you post your
/pros/bus/input/devices please?

-- 
Dmitry
