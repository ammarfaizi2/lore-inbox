Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbTIVNue (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 09:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263155AbTIVNue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 09:50:34 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:63433 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263154AbTIVNu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 09:50:28 -0400
Date: Mon, 22 Sep 2003 15:50:20 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: John Bradford <john@grabjohn.com>
Cc: aebr@win.tue.nl, ndiamond@wta.att.ne.jp, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: Translated set 3
Message-ID: <20030922135020.GA1136@ucw.cz>
References: <200309221242.h8MCgtMf000302@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309221242.h8MCgtMf000302@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 01:42:55PM +0100, John Bradford wrote:
> Sorry if there is an obvious answer to this question that I'm missing,
> but what is the advantage of using translation in set 3?
> 
> I totally agree that translated set 2 is the way to get 99% of
> keyboards working perfectly, and that the reason we use translation
> here, is because although untranslated set 2 is simpler, some laptops
> don't support this properly, and some that do have problems with BIOS
> interpretation of the codes, etc.
> 
> However, surely setups that support set 3, will support it equally
> well with and without translation?  Here, I don't see the advantage of
> enabling translation.
> 
> Why not simplify the whole problem, and either have:
> 
> * translated set 2 with workarounds for all known strange keyboards
> * untranslated set 3

Because it doesn't simplify the driver. :) The translated+set3 combo,
although doesn't make much sense, just works ...

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
