Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTFZOip (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 10:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTFZOip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 10:38:45 -0400
Received: from remt28.cluster1.charter.net ([209.225.8.38]:59592 "EHLO
	remt28.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261757AbTFZOim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 10:38:42 -0400
Subject: Re: Problems with IDE on GA-7VAXP motherboard
From: Tim McGrath <misty-@charter.net>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.30.0306261242310.24845-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0306261242310.24845-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Message-Id: <1056633178.11435.2.camel@roll>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 26 Jun 2003 09:12:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-26 at 06:50, Bartlomiej Zolnierkiewicz wrote:
> Maybe you can use dosemu under Linux instead?
> http://www.dosemu.org
Well, yes, it works - problem is I can't figure out how to get sound nor
VGA/SVGA working in it, and I need both to play the games I use DOS for.

> There is also GPLed DOS replacement, maybe it doesn't use CHS info,
> if it does you have source code available ;-).
> http://www.freedos.org
Nope, not even going to try that one - I've used it before and the last
time I tried it, it had the same problems dos did. Not that it's a bad
program or anything.

Thanks for trying to help. If you know how to get dosemu working with
vga/svga and sound in linux console/x let me know.

Another option I'm going to try is booting off the 40GB disk I have
instead of the 100GB disk - should work as the CHS info given by the
bios agrees with the kernel.

We'll see.

Timothy C. McGrath

