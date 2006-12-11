Return-Path: <linux-kernel-owner+w=401wt.eu-S1762714AbWLKKDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762714AbWLKKDr (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 05:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762712AbWLKKDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 05:03:47 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:49735 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762711AbWLKKDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 05:03:46 -0500
Date: Mon, 11 Dec 2006 11:03:25 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Benny Amorsen <benny+usenet@amorsen.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Window scaling problem?
In-Reply-To: <m33b7mhjfh.fsf@ursa.amorsen.dk>
Message-ID: <Pine.LNX.4.61.0612111102230.11941@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0612101001390.9675@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0612101507180.23130@lancer.cnet.absolutedigital.net>
 <m33b7mhjfh.fsf@ursa.amorsen.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 11 2006 10:26, Benny Amorsen wrote:
>>>>>> "CP" == Cal Peake <cp@absolutedigital.net> writes:
>
>CP> I saw this with kernels v2.6.16, v2.6.17, and v2.6.18. Windows XP
>CP> however didn't seem to have any problems. So unless Windows
>CP> doesn't have window scaling on by default (or uses a workaround)
>CP> it could be a broken kernel.
>
>XP doesn't do Window Scaling by default, but Vista will. Hopefully
>that should flush out the old PIX's. Versions old enough to break
>Window Scaling are old enough to be insecure anyway.

Is there some test utility I can run that reliably says if there is a 
broken window scaler in the path to an arbitrary host?


	-`J'
-- 
