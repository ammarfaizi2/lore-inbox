Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbTEMNDz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 09:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbTEMNDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 09:03:55 -0400
Received: from mail.ithnet.com ([217.64.64.8]:16147 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S261182AbTEMNDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 09:03:54 -0400
Date: Tue, 13 May 2003 15:16:30 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: What exactly does "supports Linux" mean?
Message-Id: <20030513151630.75ad4028.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I recently came across a very annoying question regarding Linux compatibility.
It rises a fundamental question which should be discussed, IMHO. 
Facts are:
I bought a card from some vendor, claiming "support for Linux". I tried to make
it work in a configuration with a standard 2.4.20 kernel from kernel.org. The
drivers (kernel modules) are binary-only. They did not load because of a
version mismatch. Asking for versions loadable with standard kernels, I got the
response that they only support kernels from Red Hat and SuSE, but no standard
kernels.
This leads to my simple question: how can one claim his product supports linux,
if it does not work with a kernel.org kernel? Is there any paper or open
statement from big L (hello btw ;-) available what you have to do to call
yourself "supporting linux"?
I know that the technical background is ridiculous, because it should very well
be possible to recompile their drivers under stock 2.4.20, but it looks like
they don't want to, simply.
I am in fact a bit worried about this behaviour, because I take it as a first
step to a general market split up already known to *nix.
My general conclusion would be that something not working with a standard
kernel cannot be called "supporting linux", no matter what distros ever are
supported. You may call me purist...
Any ideas?

Regards,
Stephan
