Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310749AbSDDGFb>; Thu, 4 Apr 2002 01:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310740AbSDDGFV>; Thu, 4 Apr 2002 01:05:21 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:5310 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S310666AbSDDGFR>;
	Thu, 4 Apr 2002 01:05:17 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: Frame Relay stack on Linux
In-Reply-To: <3CA99EA0.1B2391FF@wipro.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 03 Apr 2002 21:14:43 +0200
Message-ID: <m3pu1g8uho.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Madhavan N.S." <madhavan.nair@wipro.com> writes:

> We are developing  Frame Relay stack on Linux 2.4 kernel.

Have you looked at existing implementations: drivers/net/wan/hdlc_fr.c
(and other files) and comx-proto-fr.c in the same dir?

I'm also told "Tulika Pradhan" <tulikapradhan@hotmail.com> is going to
start working on SVC support.
-- 
Krzysztof Halasa
Network Administrator
