Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161877AbWKJRO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161877AbWKJRO3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 12:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161878AbWKJRO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 12:14:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41180 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161877AbWKJRO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 12:14:28 -0500
Message-ID: <4554B36E.9030006@sandeen.net>
Date: Fri, 10 Nov 2006 11:14:22 -0600
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: "Igor A. Valcov" <viaprog@gmail.com>
CC: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: XFS filesystem performance drop in kernels 2.6.16+
References: <bde600590611090930g3ab97aq3c76d7bca4ec267f@mail.gmail.com>	 <4553F3C6.2030807@sandeen.net>	 <Pine.LNX.4.61.0611101259490.6068@yvahk01.tjqt.qr> <bde600590611100516u7b8ca1bfs74d3cc8b78eb3520@mail.gmail.com>
In-Reply-To: <bde600590611100516u7b8ca1bfs74d3cc8b78eb3520@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Igor A. Valcov wrote:
> Below is a simplified version of the test program, and results of
> testing different kernels/filesystems/mount options. The results are a
> little different from the ones described in the initial post (this
> time performance decreased "only" 2 times), but the general tendency
> is clearly the same.

I imagine that I know the answer, but to be sure you might put some time
checks into your test app to see -which- portion of the test is taking
the bulk of the time.

-Eric
