Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266914AbUH1PUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266914AbUH1PUl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 11:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267195AbUH1PUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 11:20:40 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:64235 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S266914AbUH1PTP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 11:19:15 -0400
From: michel Xhaard <mxhaard@magic.fr>
To: Paul Jakma <paul@clubi.ie>, Kenneth Lavrsen <kenneth@lavrsen.dk>
Subject: Re: [linux-usb-devel] Re: Summarizing the PWC driver questions/answers
Date: Sat, 28 Aug 2004 17:55:12 +0200
User-Agent: KMail/1.5.4
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <6.1.2.0.2.20040827215445.01c4ddb0@inet.uni2.dk> <6.1.2.0.2.20040827233253.01c36210@inet.uni2.dk> <Pine.LNX.4.61.0408280114460.2441@fogarty.jakma.org>
In-Reply-To: <Pine.LNX.4.61.0408280114460.2441@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200408281755.12496.mxhaard@magic.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Samedi 28 Août 2004 02:22, Paul Jakma a écrit :
> Interesting comment on /.:
>
> http://linux.slashdot.org/comments.pl?sid=119578&cid=10089410
>
> From the LavaRND people. Apparently images produced with the binary
> pcwx portion loaded (full-sized frame) had *less* entropy than the
> smaller images produced without. Hence they speculate that the
> function of the binary pcwx part is actually to interpolate the
> 160x120 image to the bigger 640x480 size, and has little to do with
> hardware..
>
> allegedly..
>
> regards,
hmm, if the compressed frame size did not change maybe but i doubt :)
Regards
-- 
Michel Xhaard

