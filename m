Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263090AbUCSTEo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 14:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263118AbUCSTEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 14:04:44 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:62691 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263090AbUCSTEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 14:04:42 -0500
Date: Fri, 19 Mar 2004 20:03:55 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Gerhard Mack <gmack@innerfire.net>
Cc: Peter Williams <peterw@aurema.com>,
       =?iso-8859-1?B?IkZy6WTpcmljIEwuIFcuIE1ldW5pZXIi?= 
	<1@pervalidus.net>,
       linux-kernel@vger.kernel.org
Subject: Re: XFree86 seems to be being wrongly accused of doing the wrong thing
Message-ID: <20040319190355.GA30255@ucw.cz>
References: <40593015.9090507@aurema.com> <Pine.LNX.4.58.0403180346000.1276@pervalidus.dyndns.org> <40594984.3010001@aurema.com> <Pine.LNX.4.58.0403191236170.10220@innerfire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0403191236170.10220@innerfire.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 12:37:37PM -0500, Gerhard Mack wrote:
> On Thu, 18 Mar 2004, Peter Williams wrote:
> 
> > Frédéric L. W. Meunier wrote:
> > > Wrongly ?
> >
> > Yes, wrongly.  XFree86 wasn't even running when the messages appeared so
> > there's no way that it could be to blame.  Also no keys had been pressed
> > or released.
> 
> I have a machine here I see that message on before the init scripts even
> load.

Quick question: Does it go away if you compile USB support into the
kernel statically?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
