Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129805AbQKFNnn>; Mon, 6 Nov 2000 08:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129906AbQKFNnX>; Mon, 6 Nov 2000 08:43:23 -0500
Received: from chmls05.mediaone.net ([24.147.1.143]:15272 "EHLO
	chmls05.mediaone.net") by vger.kernel.org with ESMTP
	id <S129828AbQKFNnO>; Mon, 6 Nov 2000 08:43:14 -0500
Date: Mon, 6 Nov 2000 08:44:43 -0500
From: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
Message-ID: <20001106084443.A1129@pimlott.ne.mediaone.net>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3A0661A1.668BD8CB@mandrakesoft.com> <Pine.LNX.4.21.0011060752250.15143-100000@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <Pine.LNX.4.21.0011060752250.15143-100000@imladris.demon.co.uk>; from dwmw2@infradead.org on Mon, Nov 06, 2000 at 08:00:05AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2000 at 08:00:05AM +0000, David Woodhouse wrote:
> I'm more interested in the case where the module is loaded for the second
> time:

Is there really a reason to unload a module in normal usage?  Beyond
miniscule memory savings and hack value?  You can solve the whole
problem with a loud "don't do that".

Andrew
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
