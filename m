Return-Path: <linux-kernel-owner+w=401wt.eu-S1753692AbWLRJ5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692AbWLRJ5s (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 04:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753691AbWLRJ5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 04:57:48 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:57134 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753688AbWLRJ5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 04:57:46 -0500
Date: Mon, 18 Dec 2006 12:57:40 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-crypto@vger.kernel.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ANN] Acrypto asynchronous crypto layer 2.6.19 release.
Message-ID: <20061218095740.GA5219@2ka.mipt.ru>
References: <20061216191521.GA26549@2ka.mipt.ru> <4586458E.6000503@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <4586458E.6000503@dungeon.inka.de>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 18 Dec 2006 12:57:41 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 08:38:54AM +0100, Andreas Jellinghaus (aj@dungeon.inka.de) wrote:
> Does acrypto still have the same size restrictions
> I ran into with the last release?

Actually I do not recall what is 'size retrictions' - if you talk about
possibility to use software crypto provider, which supports one cipher
in a time, then yes, but it is intended to be used with hardware though.
Otherwise I do not recall any problems pointed to me.

> Thanks, Andreas

-- 
	Evgeniy Polyakov
