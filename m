Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266463AbUFUVIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266463AbUFUVIv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 17:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266468AbUFUVIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 17:08:51 -0400
Received: from gprs187-64.eurotel.cz ([160.218.187.64]:17025 "EHLO
	midnight.ucw.cz") by vger.kernel.org with ESMTP id S266463AbUFUVIt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 17:08:49 -0400
Date: Mon, 21 Jun 2004 23:09:27 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Michael Langley <nwo@hacked.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with psmouse detecting generic ImExPS/2
Message-ID: <20040621210927.GC2078@ucw.cz>
References: <20040621021651.4667bf43.nwo@hacked.org> <20040621082831.GC1200@ucw.cz> <20040621124506.18b1f67a.nwo@hacked.org> <20040621183459.GA1969@ucw.cz> <20040621143253.759e21c1.nwo@hacked.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040621143253.759e21c1.nwo@hacked.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 02:32:53PM -0500, Michael Langley wrote:

> > > [root@purgatory root]# modprobe psmouse proto=exps
> > > Jun 21 12:41:36 purgatory kernel: input: ImExPS/2 Generic Wheel Mouse on isa0060/serio1
> > > 
> > > Much thanks for the help.  I couldn't live without the extra buttons in X.
> > 
> > Can you check if this patch fixes it for you as well?

> Indeed, it does.  And much more efficiently.  Thanks again.

Ok, I'll push it upstream.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
