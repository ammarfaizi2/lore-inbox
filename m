Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271818AbRH1QyE>; Tue, 28 Aug 2001 12:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271817AbRH1Qxt>; Tue, 28 Aug 2001 12:53:49 -0400
Received: from relay1.zonnet.nl ([62.58.50.37]:32689 "EHLO relay1.zonnet.nl")
	by vger.kernel.org with ESMTP id <S271818AbRH1Qx3>;
	Tue, 28 Aug 2001 12:53:29 -0400
Message-ID: <3B8BCC7E.59F1DE01@linux-m68k.org>
Date: Tue, 28 Aug 2001 18:53:18 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <E15blMM-0006Dv-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alan Cox wrote:

> The typing of min() is something I do agree with Linus about (for once 8)),
> and making people think about them is a good idea. When DaveM proposed the
> original his patches showed up a bug in the older ixj driver immediately.

No doubt, that it fixed bugs now. What I'm worried about is whether it
really avoids bugs in the future and isn't a new source of bugs.

bye, Roman
