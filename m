Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbUASTfK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 14:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUASTfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 14:35:10 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:38661 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262458AbUASTfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 14:35:06 -0500
Date: Mon, 19 Jan 2004 20:34:55 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: fire-eyes <sgtphou@fire-eyes.dynup.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Update: 2.6.1: atkbd.c errors + mouse errors with a belkin KVM
Message-ID: <20040119203455.B1073@pclin040.win.tue.nl>
References: <400C2D6A.1000309@fire-eyes.dynup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <400C2D6A.1000309@fire-eyes.dynup.net>; from sgtphou@fire-eyes.dynup.net on Mon, Jan 19, 2004 at 02:18:02PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 02:18:02PM -0500, fire-eyes wrote:
> Update: I forgot to mention I saw this log as well:
> 
> kernel: atkbd.c: keyboard on isa00060/serio0 reports too many keys pressed.

Also informative only.
The "too many keys pressed" is too specific - more correct is "an error".

Switching may easily cause a small amount of garbage to happen
at the moment of switching. So nothing is bad here.

