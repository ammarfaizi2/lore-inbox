Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264728AbUFLMRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264728AbUFLMRW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 08:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264729AbUFLMRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 08:17:22 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:128 "EHLO cloud.ucw.cz")
	by vger.kernel.org with ESMTP id S264728AbUFLMRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 08:17:21 -0400
Date: Sat, 12 Jun 2004 14:17:21 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: touchpad (PS/2) mouse detection problem.
Message-ID: <20040612121721.GA1127@ucw.cz>
References: <40C8EA4B.7070604@enenet.com> <MPG.1b33c0a163d6f2e59896ca@news.gmane.org> <40C9CD38.2090501@enenet.com> <MPG.1b340874c275a9479896cb@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MPG.1b340874c275a9479896cb@news.gmane.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2004 at 09:39:21PM +0200, Giuseppe Bilotta wrote:
> Vadim Garber ENEnet wrote:
> > < > PCI PS/2 keyboard and PS/2 mouse controller
>   ^^^
> 
> You need this too.

Definitely not. This is a driver for a PCI PS/2 controller so far found
only in a Mobility Electronic docking station.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
