Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbRCZVX1>; Mon, 26 Mar 2001 16:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129259AbRCZVXR>; Mon, 26 Mar 2001 16:23:17 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:24593 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S129166AbRCZVW6>;
	Mon, 26 Mar 2001 16:22:58 -0500
Date: Mon, 26 Mar 2001 23:23:26 +0200 (CEST)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Theodoor Scholte <tscholte@wanadoo.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Compiling problem kernel 2.4.2
In-Reply-To: <5.0.2.1.2.20010326204754.02751100@pop.wanadoo.nl>
Message-ID: <Pine.LNX.4.30.0103262319200.30924-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2001, Theodoor Scholte wrote:

> There are no relevant messsages in that file.

Strange, but I bet that you can compile again, right?  (Just remove the
broken compile.h that the dd command created)  Must have been an NFS
fluke, and without any more precise error messages, there is not much to
do, unless you can reproduce it.

/Tobias


