Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266381AbUA2V0H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 16:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266403AbUA2V0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 16:26:07 -0500
Received: from maximus.kcore.de ([213.133.102.235]:40089 "EHLO
	maximus.kcore.de") by vger.kernel.org with ESMTP id S266381AbUA2V0F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 16:26:05 -0500
From: Oliver Feiler <kiza@gmx.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: 2.6.1-rc2 + aha152x still oopses
Date: Thu, 29 Jan 2004 22:25:00 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200401281458.47217.kiza@gmx.net> <Pine.LNX.4.44.0401292100001.4784-100000@poirot.grange> <20040129125613.0757af61.rddunlap@osdl.org>
In-Reply-To: <20040129125613.0757af61.rddunlap@osdl.org>
X-PGP-Key-Fingerprint: E9DD 32F1 FA8A 0945 6A74  07DE 3A98 9F65 561D 4FD2
X-PGP-Key: http://kiza.kcore.de/pgpkey
X-Species: Snow Leopard
X-Operating-System: Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200401292225.01143.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 January 2004 21:56, Randy.Dunlap wrote:
> Hi,
>
> The aha152x maintainer (Juergen E. Fischer) has already replied:
>
> No, that was an other bug.  Try attached patch.  I already submitted it
> to Andrew Morton and expect it to appear in 2.6.2.

Yes, I got a couple of patches from Jürgen and that fixed the Oops. The driver 
works just fine now for me.

Bye,
Oliver

-- 
Oliver Feiler  <kiza@(kcore.de|lionking.org|gmx[pro].net)>

