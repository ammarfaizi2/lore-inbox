Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316777AbSEUXXo>; Tue, 21 May 2002 19:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316780AbSEUXXn>; Tue, 21 May 2002 19:23:43 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:54022 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S316777AbSEUXXm>; Tue, 21 May 2002 19:23:42 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Message-ID: <86256BC0.00807DCA.00@smtpnotes.altec.com>
Date: Tue, 21 May 2002 18:20:56 -0500
Subject: Re: Linux-2.5.17
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Thanks for the information.

So, I'm just getting used to the idea of using new tools to build kernels, and
now I learn that 2.5 breaks an ordinary program that I use all day, every day.
It just keeps getting better and better...





"David S. Miller" <davem@redhat.com> on 05/21/2002 04:30:11 PM

To:   Wayne Brown/Corporate/Altec@Altec
cc:   linux-kernel@vger.kernel.org

Subject:  Re: Linux-2.5.17



   From: Wayne.Brown@altec.com
   Date: Tue, 21 May 2002 13:52:08 -0500

   Under 2.5.17 there is a problem with gtop 1.0.9.

The /proc/meminfo output changed, and this makes a lot of programs
reading that file explode.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




