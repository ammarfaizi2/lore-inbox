Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288959AbSBRXeZ>; Mon, 18 Feb 2002 18:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288969AbSBRXeG>; Mon, 18 Feb 2002 18:34:06 -0500
Received: from dsl-213-023-040-169.arcor-ip.net ([213.23.40.169]:57744 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288959AbSBRXd7>;
	Mon, 18 Feb 2002 18:33:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andries.Brouwer@cwi.nl, torvalds@transmeta.com
Subject: Re: [PATCH] size-in-bytes
Date: Tue, 19 Feb 2002 00:38:39 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <UTC200202182329.XAA03046.aeb@cwi.nl>
In-Reply-To: <UTC200202182329.XAA03046.aeb@cwi.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16cxMl-0000xG-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 19, 2002 12:29 am, Andries.Brouwer@cwi.nl wrote:
> >> This is ugly, one finds a lot of shifting left and right, as in
> >>      limit = (size << BLOCK_SIZE_BITS) >> sector_bits;
> 
> > We want to stay with the shift counts.
> 
> You misunderstand.
> I meant what I said in a very literal way, not as some kind
> of colloquial expression.
> And "left and right" has been replaced by "right".

Right, sorry.

-- 
Daniel
