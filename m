Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130253AbRBMGNx>; Tue, 13 Feb 2001 01:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130313AbRBMGNd>; Tue, 13 Feb 2001 01:13:33 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:57349 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130253AbRBMGNc>; Tue, 13 Feb 2001 01:13:32 -0500
Message-ID: <3A88D06B.26453D40@transmeta.com>
Date: Mon, 12 Feb 2001 22:12:59 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Adrian Levi <adrian@lefty.dyndns.org>
CC: alan@lxorguk.ukuu.org.uk, werner.almesberger@epfl.ch,
        linux-kernel@vger.kernel.org
Subject: Re: LILO and serial speeds over 9600
In-Reply-To: <Pine.LNX.4.21.0102131506230.30955-100000@lefty.dyndns.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Levi wrote:
> 
> I usually lurk on the list and don't contribute but I would like to
> place my 2 bob in to the fro. Would a modified X-Modem protocol stack suit
> this operation? No sliding window and don't send anything until you
> receive an ack back?
> 

Not particularly.  Xmodem and TFTP are very similar.

Anyway, I repeat what I said about there being too many cooks in the
kitchen at the moment...

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
