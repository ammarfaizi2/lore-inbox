Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265961AbUAKTrG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 14:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265967AbUAKTrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 14:47:05 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:52751 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S265961AbUAKTrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 14:47:02 -0500
Date: Sun, 11 Jan 2004 20:46:57 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: sven kissner <sven.kissner@consistencies.net>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: logitech cordless desktop deluxe optical keyboard issues
Message-ID: <20040111194657.GA1975@win.tue.nl>
References: <UTC200401111903.i0BJ3nV06355.aeb@smtp.cwi.nl> <200401112035.38414.sven.kissner@consistencies.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401112035.38414.sven.kissner@consistencies.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 08:35:34PM +0100, sven kissner wrote:

> nice! i can assign the keys. thanks andries. is there a (kbd-)configuration 
> file where this mapping should be done (or a recommendation)? 

There are many distributions, and all arrange such things
a bit different again. If you want to assign to these keys,
probably using loadkeys, then the ./sk command must precede
the loadkeys command. Maybe such stuff lives in /etc/rc.d/kbd
or maybe in /etc/rc.d/rc.sysinit, or some such place.
There will be a default keymap somewhere that you will want to adapt.

Andries

