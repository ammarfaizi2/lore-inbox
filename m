Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVBGKDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVBGKDd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 05:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVBGKDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 05:03:33 -0500
Received: from styx.suse.cz ([82.119.242.94]:48519 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261386AbVBGKDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 05:03:32 -0500
Date: Mon, 7 Feb 2005 11:04:24 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-input@atrey.karlin.mff.cuni.cz,
       linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] input: make some code static
Message-ID: <20050207100424.GH5685@ucw.cz>
References: <20050204213955.GE19408@stusta.de> <d120d50005020413563d031866@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50005020413563d031866@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 04:56:45PM -0500, Dmitry Torokhov wrote:
> On Fri, 4 Feb 2005 22:39:55 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> > This patch makes some needlessly global code static.
> > 
> 
> Hi Adrian,
> 
> I merged your patch into my tree and it is ready for Vojtech to pull from.
 
Yes, it's now in my tree, too.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
