Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266376AbUITMez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266376AbUITMez (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 08:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266463AbUITMez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 08:34:55 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:23208 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S266376AbUITMes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 08:34:48 -0400
Date: Mon, 20 Sep 2004 14:34:46 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Olaf Hering <olh@suse.de>
cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
In-Reply-To: <20040920121949.GA24304@suse.de>
Message-ID: <Pine.LNX.4.61.0409201428430.3460@scrub.home>
References: <20040920094602.GA24466@suse.de> <Pine.LNX.4.61.0409201220200.3460@scrub.home>
 <20040920105618.GB24928@suse.de> <Pine.LNX.4.61.0409201311050.3460@scrub.home>
 <20040920112607.GA19073@suse.de> <Pine.LNX.4.61.0409201331320.3460@scrub.home>
 <20040920115032.GA21631@suse.de> <Pine.LNX.4.61.0409201357540.877@scrub.home>
 <20040920120752.GA23315@suse.de> <Pine.LNX.4.61.0409201413030.877@scrub.home>
 <20040920121949.GA24304@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 20 Sep 2004, Olaf Hering wrote:

> > What happens to /dev/loop0?
> 
> I dont know, whats supposed to happen? losetup -d?

Yes, depending on how it was mounted, but that information isn't in 
/proc/mounts.
(BTW how difficult was it to find this out yourself? Have you even tried 
it?)

bye, Roman
