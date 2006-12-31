Return-Path: <linux-kernel-owner+w=401wt.eu-S932706AbWLaDoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932706AbWLaDoq (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 22:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932710AbWLaDoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 22:44:46 -0500
Received: from smtp151.iad.emailsrvr.com ([207.97.245.151]:34531 "EHLO
	smtp151.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932706AbWLaDop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 22:44:45 -0500
Message-ID: <45973283.7060801@gentoo.org>
Date: Sat, 30 Dec 2006 22:46:11 -0500
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 2.0b1 (X11/20061221)
MIME-Version: 1.0
To: Larry Finger <larry.finger@lwfinger.net>
CC: LKML <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>, alsa-devel@alsa-project.org
Subject: Re: Regression in 2.6.19 and 2.6.20 for snd_hda_intel
References: <45971053.7040609@lwfinger.net> <45971F39.4060301@gentoo.org> <45972EFD.3010103@lwfinger.net>
In-Reply-To: <45972EFD.3010103@lwfinger.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry Finger wrote:
> You are correct. Only the "hda_codec-Add independent headphone volume control" needs to be reverted.

The best course of action is probably to file a report here:
https://bugtrack.alsa-project.org/alsa-bug

Daniel
