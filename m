Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbUASSGD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 13:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbUASSGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 13:06:03 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:14481 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S261974AbUASSFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 13:05:36 -0500
Date: Mon, 19 Jan 2004 10:05:05 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Miek Gieben <miekg@atoom.net>
Cc: linux-kernel@vger.kernel.org, Nathan Poznick <kraken@drunkmonkey.org>
Subject: Re: aacraid and 2.6
Message-ID: <20040119180505.GS1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Miek Gieben <miekg@atoom.net>,
	linux-kernel@vger.kernel.org,
	Nathan Poznick <kraken@drunkmonkey.org>
References: <20040119102647.GA23288@atoom.net> <20040119135228.GA7935@tao.wang-fu.org> <20040119135619.GA32393@atoom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040119135619.GA32393@atoom.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 02:56:19PM +0100, Miek Gieben wrote:
> [On 19 Jan, @14:52, Nathan wrote in "Re: aacraid and 2.6 ..."]
> > Thus spake Miek Gieben:
> > > Hello,
> > > 
> > > Last week I tried to get aacraid working under 2.6.1, which failed.  In
> > > http://www.kernel.org/pub/linux/kernel/people/akpm/must-fix/must-fix-7.txt it
> > > says:
> > > 
> > > 	o ideraid hasn't been ported to 2.5 at all yet.
> > 
> > However, aacraid is not ideraid.  I'm using the aacraid driver on a Dell
> > PERC3 controller with no problems so far on 2.6.1-mm4.
> 
> hmmm, did you have any luck with 2.6.1?
> 
> In this case it's a SATA raid from Adaptec. So, if aacraid if not ide-raid, why
> doesn't it work? 

And what errors did you get?
