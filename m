Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbTJPTCv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 15:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbTJPTCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 15:02:51 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:42114 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263107AbTJPTCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 15:02:50 -0400
Date: Thu, 16 Oct 2003 20:03:53 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310161903.h9GJ3r6r002059@81-2-122-30.bradfords.org.uk>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org, val@nmt.edu
In-Reply-To: <Pine.LNX.4.53.0310161453240.814@chaos>
References: <1066163449.4286.4.camel@Borogove>
 <20031015133305.GF24799@bitwizard.nl>
 <3F8D6417.8050409@pobox.com>
 <20031016162926.GF1663@velociraptor.random>
 <Pine.LNX.4.53.0310161453240.814@chaos>
Subject: Re: Transparent compression in the FS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from "Richard B. Johnson" <root@chaos.analogic.com>:
> No! Not true. 'lossy' means that you can't recover the original
> data. Some music compression and video compression schemes are
> lossy. If you can get back the exact input data, it's not lossy.

Sorry, I wasn't clear in my description.  What I meant was that you
can't have an algorithm that can compress all possible values of N
bits in to less than N bits, without expanding some of them.  Of
course, you can compress N values in to <N values, compressors do that
by definition :-)

John.
