Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265956AbUFOVNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265956AbUFOVNF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 17:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265960AbUFOVNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 17:13:05 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:31366 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265956AbUFOVNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 17:13:02 -0400
Date: Tue, 15 Jun 2004 23:13:46 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Karel =?iso-8859-1?Q?Kulhav=FD?= <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Switching off PS/2 keyboard
Message-ID: <20040615211346.GA3141@ucw.cz>
References: <E1BaDva-0001Y8-LK@beton.cybernet.src> <20040615132849.A5968@beton.cybernet.src> <20040615150522.GA5602@ucw.cz> <20040615171653.D6843@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040615171653.D6843@beton.cybernet.src>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 05:16:53PM +0000, Karel Kulhavý wrote:
> On Tue, Jun 15, 2004 at 05:05:22PM +0200, Vojtech Pavlik wrote:
> > On Tue, Jun 15, 2004 at 01:28:49PM +0000, Karel Kulhavý wrote:
> > 
> > > Is it possible to switch off PS/2 keyboard support in 2.4.25 make menuconfig?
> > > I have searched through the make menuconfig and didn't find anything looking
> > > like that.
> > 
> > It is only possible in 2.6.
> 
> OK, thanks.
> 
> Is it possible to switch off AT keyboard in 2.4?
> Is it possible to switch off AT keyboard in 2.6?
 
AT Keyboard is the same as a PS/2 Keyboard from the OS point of view,
but because neither is an USB keyboard, I think you knew the answers
already.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
