Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbUBDNWT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 08:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbUBDNWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 08:22:19 -0500
Received: from gprs178-245.eurotel.cz ([160.218.178.245]:1920 "EHLO
	midnight.ucw.cz") by vger.kernel.org with ESMTP id S261881AbUBDNWP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 08:22:15 -0500
Date: Wed, 4 Feb 2004 14:22:30 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Koala Gnu <koala.gnu@tiscali.it>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ps2 mouse
Message-ID: <20040204132230.GA406@ucw.cz>
References: <4020C492.4020008@tiscali.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4020C492.4020008@tiscali.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 11:08:18AM +0100, Koala Gnu wrote:
> Hi all,
> 
> I compiled 2.6.1 kernel on my computer and the behavior of my mouse is 
> changed.
> It seems to be too sensitive and then unusable.
> This will happen both in text mode (using gpm) and X. The mouse works 
> fine in 2.4.
> I read from the mail list archive that this is not a new problem and 
> several suggestions have been submitted.
> 
> I tried using:
> 
>    psmouse_noext=1
> 
> as boot parameter but it does not work.
> 
> Then I tried also with
> 
>    psmouse_rate=60 psmouse_resolution=200
> 
> but it does not work too.
> 
> I have read also the FAQ about problems in input subsystem for 2.6, but 
> it seems there is no answer to my problem.
> 
> Any other suggestion?

Did you really check FAQ #2? The one with two mouse definitions in
XF86Config?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
