Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSFIR1C>; Sun, 9 Jun 2002 13:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314077AbSFIR1B>; Sun, 9 Jun 2002 13:27:01 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:8955 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S313867AbSFIR1A>; Sun, 9 Jun 2002 13:27:00 -0400
Subject: Re: [PATCH][2.5] make kernel scheduler use list_move_tail (1 occ)
From: Robert Love <rml@tech9.net>
To: Lightweight patch manager <patch@luckynet.dynu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1023643356.1180.119.camel@sinai>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 09 Jun 2002 10:26:52 -0700
Message-Id: <1023643612.912.122.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-09 at 10:22, Robert Love wrote:

> I guess this would be fine if I knew what list_move_tail did... or if I
> had it in my tree:

Oh I see there was an earlier patch that added these new macros,
sorry... that should of been mentioned :)

Yes, this is fine with me.

	Robert Love





