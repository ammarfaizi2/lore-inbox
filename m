Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265869AbTFSRtW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 13:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265870AbTFSRtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 13:49:22 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:10128 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265869AbTFSRtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 13:49:19 -0400
Date: Thu, 19 Jun 2003 20:03:08 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Samphan Raruenrom <samphan@thai.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Crusoe's persistent translation on linux?
Message-ID: <20030619200308.A2135@ucw.cz>
References: <3EF1E6CD.4040800@thai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3EF1E6CD.4040800@thai.com>; from samphan@thai.com on Thu, Jun 19, 2003 at 11:37:33PM +0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 19, 2003 at 11:37:33PM +0700, Samphan Raruenrom wrote:

> Hi,
> 
> I'm using 2.4.21 kernel on TM5800 Crusoe in Compaq TC1000 Tablet PC.
> Currently the performance is not very good but the more I learn
> about its architecture the more I'm obessesed about it (just like
> the days when I use 68000 Amiga). Too bad that there are very little
> information about the chip so I can't do anything much to improve
> the performance myself (like enlarge the translation cache? how?).

How much 'not very good' is the performance? I'm considering buying an
Sharp Actius MM10 notebook, and so far I wasn't able to find ANY numbers
on how fast a 1GHz Crusoe actually is, nevermind with Linux running on
it ... and how much running Linux affects the expected battery life.
Can you share your experience?

> On later versions of CMS (Code Morphing Software), there's a piece
> of system software called "Persistent Translation service".
> It looks like the purpose of the service is to get the translations
> from the translation cache according to each user applications run
> during the session and save them as binary files using the same name
> with ".SYS.DB" appended, e.g. MOZILLA.EXE.SY.DB, NOTEPAD.EXE.SY.DB
> 
> I guess they are the native TM5800 code "essenses (very small part
> that really get executed)" of those software. If my linux has the
> service, I imagine that after using the system for a week, my system
> will be filled by tranlated binaries and the processor will spend more
> time with native application code than with the CMS. And no one will ask
> for native crusoe compiler anymore. The best compiler is CMS.
> 
> Is it possible to have persistent translation on linux?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
