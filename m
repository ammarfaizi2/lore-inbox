Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbTFGSa6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 14:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263322AbTFGSa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 14:30:58 -0400
Received: from zero.aec.at ([193.170.194.10]:60684 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263310AbTFGSa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 14:30:58 -0400
Date: Sat, 7 Jun 2003 20:44:26 +0200
From: Andi Kleen <ak@muc.de>
To: Vojtech Pavlik <vojtech@ucw.cz>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, akpm@digeo.com,
       vojtech@suse.cz
Subject: Re: [PATCH] Making keyboard/mouse drivers dependent on CONFIG_EMBEDDED
Message-ID: <20030607184426.GA3744@averell>
References: <20030607063424.GA12616@averell> <20030607115908.K31364@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607115908.K31364@ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 11:59:08AM +0200, Vojtech Pavlik wrote:
> I'm quite OK with this, but I'd like it to give a pointer where to
> disable EMBEDDED, and also give a possibility to do it other than
> editing .config manually.

Hmm? You don't need to edit .config manually to disable EMBEDDED. It is 
a standard visible top level option in "General options"

-Andi
