Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132421AbRDFWHF>; Fri, 6 Apr 2001 18:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132425AbRDFWGy>; Fri, 6 Apr 2001 18:06:54 -0400
Received: from cr626425-a.bloor1.on.wave.home.com ([24.156.35.8]:22291 "EHLO
	spqr.damncats.org") by vger.kernel.org with ESMTP
	id <S132421AbRDFWGi>; Fri, 6 Apr 2001 18:06:38 -0400
Message-ID: <3ACE3CF7.FFDAE4B6@damncats.org>
Date: Fri, 06 Apr 2001 18:02:31 -0400
From: John Cavan <johnc@damncats.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeffrey W. Baker" <jwbaker@acm.org>
CC: gibbs@scsiguy.com, linux-kernel@vger.kernel.org
Subject: Re: Seems to be a lot of confusion about aic7xxx in linux 2.4.3
In-Reply-To: <Pine.LNX.4.33.0104060803450.12216-100000@heat.gghcwest.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeffrey W. Baker" wrote:
> So, I conclude that the patch was created incorrectly, or that something
> changed between cutting the patch and the tarball.

Compiled fine for me without the complete tarball, just patched. Now, I
went straight to ac2 (now ac3) without building the 2.4.3 stock kernel.

Have you tried a "make mrproper" on the tree?

John
