Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbTFTLnz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 07:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbTFTLnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 07:43:55 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:2764 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262934AbTFTLny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 07:43:54 -0400
Date: Fri, 20 Jun 2003 13:57:41 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: misty-@charter.net
Cc: Vojtech Pavlik <vojtech@suse.cz>, Bernd Schubert <bernd-schubert@web.de>,
       andre@linux-ide.org, linux-kernel@vger.kernel.org, despair@adelphia.net
Subject: Re: Problems with IDE on GA-7VAXP motherboard
Message-ID: <20030620135741.C17640@ucw.cz>
References: <200306191429.40523.bernd-schubert@web.de> <20030619193118.GA32406@charter.net> <20030620075249.GA7833@charter.net> <20030620105853.A16743@ucw.cz> <20030620114030.GA11827@charter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030620114030.GA11827@charter.net>; from misty-@charter.net on Fri, Jun 20, 2003 at 07:40:30AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 07:40:30AM -0400, misty-@charter.net wrote:

> Mostly, I want to know if what is listed by a -i/-I is assumed 'safe' to
> use. Certaintly I'm expecting you to say 'no, backup your data first
> before experimenting' so, you need not surprise me. However, any other
> advice you have would certaintly be appreciated. Also, I have a 486 with
> dma capable hard disks that has a non dma capable disk controller, so if
> I can get PIO modes working on it's hard disks it might speed things up
> slightly, who knows.

Well, send me the output of your dmesg (only the IDE parts),
/proc/ide/via, hdparm /dev/hd*, hdparm -i /dev/hd* and I'll write a
commentary on what means what and what's the maximum speed the thing is
expected to operate at.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
