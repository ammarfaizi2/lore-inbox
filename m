Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBUH7e>; Wed, 21 Feb 2001 02:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129098AbRBUH7X>; Wed, 21 Feb 2001 02:59:23 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:47622 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S129051AbRBUH7Q>;
	Wed, 21 Feb 2001 02:59:16 -0500
Date: Wed, 21 Feb 2001 08:59:29 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Dan Christian <dac@ptolemy.arc.nasa.gov>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: hang on mount, 2.4.2-pre4, VIA
In-Reply-To: <20010220101622.A18117@ptolemy.arc.nasa.gov>
Message-ID: <Pine.LNX.4.30.0102210856450.12445-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2001, Dan Christian wrote:
> Hello,
>   I just tried upgrading to 2.4.2-pre4 from 2.4.1 and get a hang when
> mounting the file systems.  I have the same problem with 2.4.1-ac18.

Have you tried to set LOGLEVEL in /etc/sysconfig/init to something higher
(8)? That way you may see what is happening, instead of just getting a
kernel freeze.

/Tobias


