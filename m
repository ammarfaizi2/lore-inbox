Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbVATP72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVATP72 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 10:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVATP7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 10:59:02 -0500
Received: from topaz.mcs.anl.gov ([140.221.57.209]:51102 "EHLO topaz")
	by vger.kernel.org with ESMTP id S262180AbVATP6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 10:58:30 -0500
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: intel8x0 and 2.6.11-rc1
References: <87hdlcc06e.fsf@topaz.mcs.anl.gov> <s5hfz0wrusn.wl@alsa2.suse.de>
	<878y6oaysw.fsf@topaz.mcs.anl.gov> <s5hbrbkrt6c.wl@alsa2.suse.de>
From: Narayan Desai <desai@mcs.anl.gov>
Date: Thu, 20 Jan 2005 09:58:34 -0600
In-Reply-To: <s5hbrbkrt6c.wl@alsa2.suse.de> (Takashi Iwai's message of "Thu,
 20 Jan 2005 16:55:55 +0100")
Message-ID: <87zmz49jo5.fsf@topaz.mcs.anl.gov>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Takashi" == Takashi Iwai <tiwai@suse.de> writes:

  Takashi> At Thu, 20 Jan 2005 09:46:23 -0600,
  Takashi> Narayan Desai wrote:
  >>
  >> >>>>> "Takashi" == Takashi Iwai <tiwai@suse.de> writes:
  >>
  Takashi> At Wed, 19 Jan 2005 20:19:05 -0600,
  Takashi> Narayan Desai wrote:
  >> >>
  >> >> I am running 2.6.11-rc1 (patched with software suspend2) and
  >> >> no longer get any sound output from my sound card. My old
  >> >> kernel
  >> >> 2.6.10 (with slightly older software suspend 2 patches) works
  >> >> perfectly. the hardware is recognized, and it appears to work,
  >> >> other than the lack out of output. I have also checked the
  >> >> standard volume levels type stuff.  Updating to the latest
  >> >> alsa bk patch (from 2.6.11-rc1-mm1) doesn't fix it. Can anyone
  >> >> suggest what the problem might be? my .config is
  >> >> attached. thanks..
  >>
  Takashi> If you have "Headphone Jack Sense" mixer control, try to
  Takashi> turn it off.
  >>
  >> That did the trick. thanks..

  Takashi> Glad to hear that.  What machine do you have?

ibm thinkpad t41p.
 -nld
