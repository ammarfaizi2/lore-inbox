Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264260AbUFTFaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbUFTFaE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 01:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbUFTFaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 01:30:04 -0400
Received: from mail.autoweb.net ([198.172.237.26]:22533 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S264260AbUFTFaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 01:30:00 -0400
Date: Sun, 20 Jun 2004 01:28:36 -0400
From: Ryan Anderson <ryan@michonline.com>
To: linux-kernel@vger.kernel.org
Cc: 4Front Technologies <dev@opensound.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>
Subject: Re: Stop the Linux kernel madness
Message-ID: <20040620052836.GC28363@michonline.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	4Front Technologies <dev@opensound.com>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Andrew Morton <akpm@osdl.org>
References: <40D232AD.4020708@opensound.com> <20040618004450.GT12308@parcelfarce.linux.theplanet.co.uk> <40D23EBD.50600@opensound.com> <20040618102523.GA7103@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040618102523.GA7103@merlin.emma.line.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 12:25:23PM +0200, Matthias Andree wrote:
> On Thu, 17 Jun 2004, 4Front Technologies wrote:
> 
> > That's right Al, 4Front, ATI, Nvidia are all evil!. OK so now get on with 
> > life.
> 
> Does NVidia's code break on SuSE 9.1?
> 
> What do I need commercial OSS for after all when Alsa works well for me?

Well, for what it's worth, there are a few devices out there for which
there is no open source driver:
0000:02:02.0 Multimedia audio controller: Creative Labs [SB Live! Value]
EMU10k1X
(Dell Dimension 2100, *I think* - it's at work right, and I'm not)

I believe 4Front provides the only driver for that specific device (it's
a crippled EMU10k1, probably what could be called a "WinSoundchip")

-- 

Ryan Anderson
  sometimes Pug Majere
