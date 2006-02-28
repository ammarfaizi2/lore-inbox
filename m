Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932585AbWB1VJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbWB1VJf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 16:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbWB1VJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 16:09:35 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:23467 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932585AbWB1VJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 16:09:34 -0500
Subject: Re: snd_intel8x0, 2.6.15.4: Alsa oss works, but pure alsa is way
	too fast
From: Lee Revell <rlrevell@joe-job.com>
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4404B35F.5000900@t-online.de>
References: <4404B35F.5000900@t-online.de>
Content-Type: text/plain
Date: Tue, 28 Feb 2006 16:09:31 -0500
Message-Id: <1141160971.5860.43.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-28 at 21:32 +0100, Harald Dunkel wrote:
> Hi folks,
> 
> Playing videos via mplayer I've got a problem: The Alsa-oss
> emulation (mplayer -ao oss) seems to work, but for pure Alsa
> (mplayer -ao alsa) the sound seems to be played too fast. And
> I get a stream of error messages on the terminal saying

Sounds like an mplayer bug.  If you play a .wav file with "aplay
file.wav" does it play at normal speed?

Lee

