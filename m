Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270880AbTHQUH2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 16:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270931AbTHQUH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 16:07:27 -0400
Received: from dsl-hkigw3g81.dial.inet.fi ([80.222.38.129]:5250 "EHLO
	uworld.dyndns.org") by vger.kernel.org with ESMTP id S270880AbTHQUHX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 16:07:23 -0400
Subject: Re: Centrino support
From: Jussi Laako <jussi.laako@pp.inet.fi>
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m2wude3i2y.fsf@tnuctip.rychter.com>
References: <m2wude3i2y.fsf@tnuctip.rychter.com>
Content-Type: text/plain
Organization: 
Message-Id: <1061150857.1504.12.camel@vaarlahti.uworld>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Aug 2003 23:07:37 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-15 at 21:13, Jan Rychter wrote:

> Well, that was almost 5 months ago. So I figured I'd ask if there's any
> progress -- so far the built-in wireless in my notebook still doesn't
> work with Linux and the machine is monstrously power-hungry because
> Linux doesn't scale the CPU frequency.
> 
> I know there are some Intel people on the list -- perhaps someone can
> comment?

I have made a patch set for my laptop which you may like to try. It
mainly contains stuff from -aa and -ac kernels and various other pieces.

See http://www.sonarnerd.net/projects/linux/

With this and my backport of latest XFree86 ATI drivers I have Linux
running nicely on my Compaq Evo N1015v and N1020v laptops. At least it
_subjectively_ warms up less and consumes less power under Linux
compared to Windows XP.


-- 
Jussi Laako <jussi.laako@pp.inet.fi>

