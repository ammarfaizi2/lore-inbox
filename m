Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130516AbRC0Fcw>; Tue, 27 Mar 2001 00:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130517AbRC0Fcn>; Tue, 27 Mar 2001 00:32:43 -0500
Received: from 1-227.cwb-adsl.telepar.net.br ([200.193.160.227]:6673 "EHLO
	imladris.rielhome.conectiva") by vger.kernel.org with ESMTP
	id <S130516AbRC0Fcf>; Tue, 27 Mar 2001 00:32:35 -0500
Date: Tue, 27 Mar 2001 02:30:58 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: David Konerding <dek_ml@konerding.com>
cc: Jason Madden <jmadden@spock.shacknet.nu>, linux-kernel@vger.kernel.org
Subject: Re: "mount -o loop" lockup issue
In-Reply-To: <3AC00E05.47C264D9@konerding.com>
Message-ID: <Pine.LNX.4.21.0103270229310.8261-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2001, David Konerding wrote:

> It's a bug in Linux 2.4.2, fixed in later versions.  
> Regression/quality control testing would have caught this, but the
> developers usually just break things and wait for people to complain
> as their "Regression" testers.

As said before, we're interested in people willing to do regression
tests on the kernel. Unfortunately, not all that many testers have
stepped forward and not all that many artificial tests are being run.

Good thing we still have the beta-testers to catch these things,
while running the kernel in real-world scenarios... ;)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

