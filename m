Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966059AbWKYQUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966059AbWKYQUL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 11:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966641AbWKYQUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 11:20:11 -0500
Received: from mail.gmx.de ([213.165.64.20]:38803 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S966059AbWKYQUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 11:20:09 -0500
X-Authenticated: #20450766
Date: Sat, 25 Nov 2006 17:20:06 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
cc: linux-kernel@vger.kernel.org, kernel-discuss@handhelds.org
Subject: Re: tty line discipline driver advice sought, to do a 1-byte header
 and 2-byte CRC checksum on GSM data
In-Reply-To: <20061125040614.GI16214@lkcl.net>
Message-ID: <Pine.LNX.4.60.0611251715130.4069@poirot.grange>
References: <20061125040614.GI16214@lkcl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(removed arm-linux because I am not subscribed to it from this address, 
don't know about hh)

On Sat, 25 Nov 2006, Luke Kenneth Casson Leighton wrote:

> and having read harald's email, and basically gone 'cool!', and, having
> then looked up 'tty line discipline' on google (_before_ writing
> this...) and gone 'errr...' i was wondering:
> 
> could someone kindly advise me how to write a tty line discipline
> driver?

Well, this is what I came up with when I googled for it:

http://www.eros-os.org/design-notes/LineDiscDesign.html
http://www.linux.it/~rubini/docs/serial/serial.html
http://lwn.net/Articles/87662/

That's all I can help you with - didn't actually write any ldisc as it 
wasn't the right solution for my problem.

HTH
Guennadi
---
Guennadi Liakhovetski
