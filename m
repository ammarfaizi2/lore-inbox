Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUBKEor (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 23:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbUBKEor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 23:44:47 -0500
Received: from fep04-svc.mail.telepac.pt ([194.65.5.203]:58273 "EHLO
	fep04-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id S263166AbUBKEoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 23:44:46 -0500
From: Claudio Martins <ctpm@rnl.ist.utl.pt>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [patch] Re: psmouse.c, throwing 3 bytes away
Date: Wed, 11 Feb 2004 04:44:40 +0000
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200402041820.39742.wnelsonjr@comcast.net> <200402070911.42569.murilo_pontes@yahoo.com.br> <20040209004812.GA18512@ucw.cz>
In-Reply-To: <20040209004812.GA18512@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402110444.40543.ctpm@rnl.ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi,

  Just to report that during many hours of desktop use and also some heavier 
use (like quake3 :-), the mouse behaved just fine without any glitches or 
error messages.

  So it seems that the problem is solved with your patch.

  Thanks for your work!

best regards

Claudio

On Monday 09 February 2004 00:48, Vojtech Pavlik wrote:
> On Sat, Feb 07, 2004 at 09:11:42AM +0000, Murilo Pontes wrote:
> > Problem still occurs :-(
>
> And here is a fix. Damn stupid mistake I made.


