Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288794AbSAEMaR>; Sat, 5 Jan 2002 07:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288798AbSAEMaH>; Sat, 5 Jan 2002 07:30:07 -0500
Received: from hal.astr.lu.lv ([195.13.134.67]:10627 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S288795AbSAEM3z> convert rfc822-to-8bit;
	Sat, 5 Jan 2002 07:29:55 -0500
Message-Id: <200201051229.g05CTej21415@hal.astr.lu.lv>
Content-Type: text/plain; charset=US-ASCII
From: Andris Pavenis <pavenis@latnet.lv>
To: Nathan Bryant <nbryant@optonline.net>
Subject: Re: i810_audio driver version 0.13 still broken
Date: Sat, 5 Jan 2002 14:29:39 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.A41.4.05.10112081022560.23064-100000@ieva06> <200112271110.fBRBA5S00309@hal.astr.lu.lv> <3C2B9649.7090503@optonline.net>
In-Reply-To: <3C2B9649.7090503@optonline.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 December 2001 23:44, Nathan Bryant wrote:
> Andris Pavenis wrote:
> >It still hanged machine after playing KDE startup sound. Didn't tried much
> >more and moved to my modified version of 0.12 which worked
>
> please send me your modified version again. full file would be best, not
> patch.
>
> i can't reproduce any problems here, so far, so i'm stabbing in the
> dark. if you can give more detailed information to reproduce, that would
> be nice: hardware versions, version of KDE, kde settings, (mine doesn't
> play a startup sound and artsd works fine for everything else i try),
> artsd settings. if i can reproduce, i can analyze on my own machine, if
> not, outlook is hazy ;-)

Seems that latest driver version from
	http://www.infosys.tuwien.ac.at/Staff/tom/SiS7012/
works for me (at least after some hours) with kernel 2.4.17

Andris
