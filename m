Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272560AbRHaAB7>; Thu, 30 Aug 2001 20:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272561AbRHaABt>; Thu, 30 Aug 2001 20:01:49 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:28938 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272560AbRHaABo>; Thu, 30 Aug 2001 20:01:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: ptb@it.uc3m.es, "David Woodhouse" <dwmw2@infradead.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Date: Fri, 31 Aug 2001 02:08:42 +0200
X-Mailer: KMail [version 1.3.1]
Cc: ptb@it.uc3m.es, "Herbert Rosmanith" <herp@wildsau.idv-edu.uni-linz.ac.at>,
        linux-kernel@vger.kernel.org, dhowells@cambridge.redhat.com
In-Reply-To: <200108302156.f7ULujo24456@oboe.it.uc3m.es>
In-Reply-To: <200108302156.f7ULujo24456@oboe.it.uc3m.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010831000154Z16102-32383+2552@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 30, 2001 11:56 pm, Peter T. Breuer wrote:
> One CAN rely on this behaviour so long as branch reduction (well,
> whatever it's called) is an optimizing step following constant
> expression evaluation.

"Dead code removal"

--
Daniel
