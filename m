Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129734AbQLTTEe>; Wed, 20 Dec 2000 14:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129818AbQLTTEO>; Wed, 20 Dec 2000 14:04:14 -0500
Received: from mail.valinux.com ([198.186.202.175]:3345 "EHLO mail.valinux.com")
	by vger.kernel.org with ESMTP id <S129734AbQLTTEH>;
	Wed, 20 Dec 2000 14:04:07 -0500
Date: Wed, 20 Dec 2000 04:33:04 -0800
From: David Hinds <dhinds@valinux.com>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCMCIA modem (v.90 X2) not working with 2.4.0-test12 PCMCIA services
Message-ID: <20001220043304.A1549@valinux.com>
In-Reply-To: <007101c067cc$0500c620$0b31a3ce@g1e7m6> <20001218154033.C11728@valinux.com> <20001219114614.A12948@valinux.com> <20001219154129.A1763@vger.timpanogas.org> <20001219135114.B13184@valinux.com> <20001219170516.A2039@vger.timpanogas.org> <20001220121041.A5183@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.6i
In-Reply-To: <20001220121041.A5183@vger.timpanogas.org>; from Jeff V. Merkey on Wed, Dec 20, 2000 at 12:10:41PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2000 at 12:10:41PM -0700, Jeff V. Merkey wrote:
> On Tue, Dec 19, 2000 at 05:05:16PM -0700, Jeff V. Merkey wrote:
> 
> Do you think there's a solution for this problem.  Sorry for bothering 
> you again.  I'm available if you need some help retesting and fixes.

I do not have a solution.  I have a few reports of tx timeout problems
that I have so far been unable to reproduce.  It is a sufficiently
nonspecific outcome that I don't have any good ideas for how to track
down the problem; all my attempts so far have come up blank.

-- Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
