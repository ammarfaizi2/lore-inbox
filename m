Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbTJAKEW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 06:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbTJAKEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 06:04:22 -0400
Received: from gprs146-6.eurotel.cz ([160.218.146.6]:29568 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261354AbTJAKEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 06:04:06 -0400
Date: Wed, 1 Oct 2003 12:03:35 +0200
From: Pavel Machek <pavel@suse.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Broken synaptics mouse..
Message-ID: <20031001100334.GA398@elf.ucw.cz>
References: <Pine.LNX.4.44.0309110744030.28410-100000@home.osdl.org> <Pine.LNX.4.44.0309190129170.32637-100000@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309190129170.32637-100000@telia.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I dropped the "synaptics_optional" patch, because there should not be any
> need for the config option now that we have backwards compatibility by
> default.

I believe synaptics support caused enough problems already that we
*want* it optional.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
