Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbVDXIiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbVDXIiX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 04:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbVDXIiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 04:38:22 -0400
Received: from colo.khms.westfalen.de ([213.239.196.208]:2195 "EHLO
	colo.khms.westfalen.de") by vger.kernel.org with ESMTP
	id S262289AbVDXIiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 04:38:16 -0400
Date: 24 Apr 2005 10:01:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <9VVxJIs1w-B@khms.westfalen.de>
In-Reply-To: <6f6293f10504210220744af114@mail.gmail.com>
Subject: Re: more git updates..
X-Mailer: CrossPoint v3.12d.kh15 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <d3dvps$347$1@terminus.zytor.com> <9VF1rZLXw-B@khms.westfalen.de> <9VF1rZLXw-B@khms.westfalen.de> <6f6293f10504210220744af114@mail.gmail.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

felipe.alfaro@gmail.com (Felipe Alfaro Solana)  wrote on 21.04.05 in <6f6293f10504210220744af114@mail.gmail.com>:

> On 20 Apr 2005 22:29:00 +0200, Kai Henningsen <kaih@khms.westfalen.de>
> > > wrote: If you're actually worried about it, it'd be better to just use a
> > > different hash, like one of the SHA-2's (probably a better choice
> > > anyway), instead of SHA-1.
> >
> > How could that help? *Every* hash has hash collisions. It's an unavoidable
> > result of using less bits than the original data has.
>
> SHA-2 allows for 256, 384 and 512-bit hashes, which provides greater
> resistance to collisions.

So? It's still finite.

MfG Kai
