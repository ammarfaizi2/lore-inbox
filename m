Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266347AbUARLHK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 06:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266354AbUARLHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 06:07:10 -0500
Received: from quechua.inka.de ([193.197.184.2]:47052 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S266347AbUARLHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 06:07:08 -0500
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: License question
Date: Sun, 18 Jan 2004 12:07:23 +0100
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Message-Id: <pan.2004.01.18.11.07.22.275127@dungeon.inka.de>
References: <20040117195702.67bc83ea.pochini@shiny.it>
To: linux-kernel@vger.kernel.org, Giuliano Pochini <pochini@shiny.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jan 2004 18:59:54 +0000, Giuliano Pochini wrote:

> Is it possile to include in the kernel distro some code with this
> BSD-style license ?

ah, header and buttom are the same as the XFree license, the restrictions
are from the BSD license. (Some very small differences like "deal with" /
"deal in" and "disclaimers" vs. "disclaimer".) Those two licenses are well
known to be free, open source and GPL compatible.

So the license is perfectly fine, you can use this code in the linux
kernel. 

I used "wdiff" to compare to this license text to the BSD and XFree
license. That is a very nice tool suited for this task. 
In case you have any influence on licensing: It is a lot better to
use some well known and accepted license, than writing your own,
even if like in this case, the license is completely build from two
existing licenses which makes the analysis very easy. 

Regards, Andreas

