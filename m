Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271275AbTGPXni (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 19:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271292AbTGPXnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 19:43:37 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:40883 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S271275AbTGPXmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 19:42:49 -0400
Date: Wed, 16 Jul 2003 19:57:52 -0400
From: Matt Reppert <repp0017@tc.umn.edu>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 sound drivers?
Message-Id: <20030716195752.156ac80f.repp0017@tc.umn.edu>
In-Reply-To: <20030716233956.GS2412@rdlg.net>
References: <20030716225826.GP2412@rdlg.net>
	<3F15E1B5.4020206@pobox.com>
	<20030716233956.GS2412@rdlg.net>
Organization: Arashi no Kaze
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jul 2003 19:39:56 -0400
"Robert L. Harris" <Robert.L.Harris@rdlg.net> wrote:
> 
> That's what I'm trying to do and why I'm trying to get the sound card to
> work, it was in a previous part of this thread.  I'm trying to find out
> what drivers to load how for ALSA with a soundblaster live.

modprobe snd-emu10k1

That should take care of it, it worked perfectly fine 40 releases ago :)

Matt
