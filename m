Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbUASSO0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 13:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUASSME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 13:12:04 -0500
Received: from open.nlnetlabs.nl ([213.154.224.1]:31748 "EHLO
	open.nlnetlabs.nl") by vger.kernel.org with ESMTP id S262458AbUASSJl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 13:09:41 -0500
Date: Mon, 19 Jan 2004 19:09:30 +0100
From: Miek Gieben <miekg@atoom.net>
To: linux-kernel@vger.kernel.org, Nathan Poznick <kraken@drunkmonkey.org>
Subject: Re: aacraid and 2.6
Message-ID: <20040119180930.GA9391@atoom.net>
References: <20040119102647.GA23288@atoom.net> <20040119135228.GA7935@tao.wang-fu.org> <20040119135619.GA32393@atoom.net> <20040119180505.GS1748@srv-lnx2600.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040119180505.GS1748@srv-lnx2600.matchmail.com>
User-Agent: Vim/Mutt/Linux
X-Home: www.miek.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[On 19 Jan, @19:05, Mike wrote in "Re: aacraid and 2.6 ..."]
> > hmmm, did you have any luck with 2.6.1?
> > 
> > In this case it's a SATA raid from Adaptec. So, if aacraid if not ide-raid, why
> > doesn't it work? 
> 
> And what errors did you get?

none, when modprobing aacraid it just said:
AAC-RAID ....etc...

and no device /dev/sde found stuff like under 2.4.

grtz
      Miek
--
"So long, and thanks for all the fish."
-- Hitchhikers Guide to the Galaxy
