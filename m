Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263491AbTKQNaV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 08:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTKQNaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 08:30:21 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:21390 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263491AbTKQNaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 08:30:20 -0500
Date: Mon, 17 Nov 2003 14:30:14 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Nikita Melnikov <ku3@stud2.aanet.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AGP mode on KT-400 MB (2.6.0-test9)
Message-ID: <20031117133014.GA28386@ucw.cz>
References: <20031117125407.GA8261@stud2.aanet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031117125407.GA8261@stud2.aanet.ru>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 03:54:07PM +0300, Nikita Melnikov wrote:
> Hello.
> 
> I have Ati Rage 128 Pro, which can perfectly run in 2x mode, but agpgart
> always puts it into 1x mode. How could I change this setting? There are no
> options in BIOS dedicated to agp.
> 
> Thanks.

You can change that in XF86Config (Option "AGPMode" "2").

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
