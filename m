Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbWBSUdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWBSUdj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 15:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbWBSUdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 15:33:39 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:44215 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751039AbWBSUdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 15:33:38 -0500
Subject: Re: No sound from SB live!
From: Lee Revell <rlrevell@joe-job.com>
To: Nick Warne <nick@linicks.net>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Pavel Machek <pavel@suse.cz>,
       tiwai@suse.de, ghrt@dial.kappa.ro, perex@suse.cz,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200602192020.36343.nick@linicks.net>
References: <20060218231419.GA3219@elf.ucw.cz>
	 <7c3341450602190318o1c60e9b5w@mail.gmail.com>
	 <1140377394.2733.341.camel@mindpipe>  <200602192020.36343.nick@linicks.net>
Content-Type: text/plain
Date: Sun, 19 Feb 2006 15:33:27 -0500
Message-Id: <1140381207.2733.376.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-19 at 20:20 +0000, Nick Warne wrote:
> Every reboot 'alsactl restore' breaks on one control or another now.
> 

diff asound.state.working asound.state.bad

