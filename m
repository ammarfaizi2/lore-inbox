Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281880AbRLOExH>; Fri, 14 Dec 2001 23:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281912AbRLOEw5>; Fri, 14 Dec 2001 23:52:57 -0500
Received: from cx518206-a.irvn1.occa.home.com ([24.21.107.122]:60147 "HELO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with SMTP
	id <S281880AbRLOEwr>; Fri, 14 Dec 2001 23:52:47 -0500
Subject: Re: 2.4.17rc1aa1
To: andrea@suse.de (Andrea Arcangeli)
Date: Fri, 14 Dec 2001 20:52:55 -0800 (PST)
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br (Marcelo Tosatti),
        andrewm@uow.edu.au (Andrew Morton)
In-Reply-To: <20011214181444.B2431@athlon.random> from "Andrea Arcangeli" at Dec 14, 2001 06:14:44 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011215045255.04C6E8A6E5@cx518206-b.irvn1.occa.home.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> Marcelo, can you merge the loop-deadlock fix? (the others aren't
> trivially mergeable yet and for the tcp conntrack you'd need to ask
> Rusty first, the change is simple enough that I merged it for now)

I verified on two of my systems that the loop-deadlock fix patch works.

-Barry K. Nathan <barryn@pobox.com>
