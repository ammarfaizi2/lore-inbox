Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265063AbSK3Vjb>; Sat, 30 Nov 2002 16:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265333AbSK3Vjb>; Sat, 30 Nov 2002 16:39:31 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:6207 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S265063AbSK3Vjb>;
	Sat, 30 Nov 2002 16:39:31 -0500
Date: Sat, 30 Nov 2002 22:46:54 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: "ruckc" <ruckc@mail.tnaccess.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.50 keyboard won't work
Message-ID: <20021130214654.GB6492@win.tue.nl>
References: <200211301431.AA40632710@mail.tnaccess.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211301431.AA40632710@mail.tnaccess.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 30, 2002 at 02:31:56PM -0600, ruckc wrote:

> In 2.5.50 i am completly unable to get my keyboard to work.
> I have selected the input device->keyboard support

Check that you have enabled everything needed for the keyboard,
there is a whole list of options and they are all needed
(and the top ones explicitly say so).

[Input devices, Serial I/O, KBD controller, Keyboards, AT keyboard (or so)]
