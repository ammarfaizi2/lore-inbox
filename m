Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbUBOIZP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 03:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264383AbUBOIZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 03:25:15 -0500
Received: from papadoc.bayour.com ([212.214.70.53]:9406 "EHLO
	papadoc.bayour.com") by vger.kernel.org with ESMTP id S264374AbUBOIZD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 03:25:03 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Adaptec ARO-1130CA-C
References: <20040214085247.A20697@lists.us.dell.com>
	<20040214150400.GA70742@hollin.btc.adaptec.com>
X-PGP-Fingerprint: B7 92 93 0E 06 94 D6 22  98 1F 0B 5B FE 33 A1 0B
X-PGP-Key-ID: 0x788CD1A9
X-URL: http://www.bayour.com/
From: Turbo Fredriksson <turbo@bayour.com>
Organization: Bah!
Date: 15 Feb 2004 09:24:58 +0100
In-Reply-To: <20040214150400.GA70742@hollin.btc.adaptec.com>
Message-ID: <8765e8wy05.fsf@papadoc.bayour.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Scott Long <scott_long@btc.adaptec.com>:

> On Sat, Feb 14, 2004 at 09:52:47AM -0500, Matt Domsch wrote:
> > On Sat, Feb 14, 2004 at 03:11:33PM +0100, Turbo Fredriksson wrote:
> > > So the question is: IS it (my RAIDport II card) supported by the
> > > aacraid driver, in either 2.4 _or_ (if need be) the 2.6 kernels?
> > 
> > To the best of my knowledge, no, aacraid does not support any of the
> > RAIDport cards.
> > 
> 
> That is correct, the AAA and ARO products are not supported by the
> aacraid nor dpti20 drivers, nor any other linux driver, open source or
> otherwise.

Is there a reason why not? Other than 'non-one have the time' etc that is...
I would _REALLY APRECIATE_ if someone took the time to write one...

I'm most liklely NOT up to it, I'm not that good a programmer (never done
any serious kernel hacking since 1.3 or thereabouts).


If someone cared, I could even lend the mb/raid card to whomever wanted/had
the time to do it...
