Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271334AbRHTQQn>; Mon, 20 Aug 2001 12:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271332AbRHTQQ1>; Mon, 20 Aug 2001 12:16:27 -0400
Received: from smtp6.mindspring.com ([207.69.200.110]:36103 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S271334AbRHTQQN>; Mon, 20 Aug 2001 12:16:13 -0400
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
From: Robert Love <rml@tech9.net>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Johan Adolfsson <johan.adolfsson@axis.com>,
        Oliver Xymoron <oxymoron@waste.org>, linux-kernel@vger.kernel.org,
        riel@conectiva.com.br
In-Reply-To: <3B80EADC.234B39F0@evision-ventures.com>
In-Reply-To: <Pine.LNX.4.30.0108182234250.31188-100000@waste.org>
	<998193404.653.12.camel@phantasy> <3B80E01B.2C61FF8@evision-ventures.com>
	<21a701c12963$bcb05b60$0a070d0a@axis.se> 
	<3B80EADC.234B39F0@evision-ventures.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.19.07.08 (Preview Release)
Date: 20 Aug 2001 12:15:51 -0400
Message-Id: <998324166.2936.1.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Aug 2001 12:47:56 +0200, Martin Dalecki wrote:
> The device get's powerd up at a random time for the attacker.
> That's entierly sufficient if you assume that your checksum function
> f(i) hat the property that there is no function g, where we have
> f(i+1)=g(f(i)), where g has a polynomial order over the time domain.
> i is unknown for the attacker.

isnt that the case?

also, its not even that g completes in polynomial time. its that g is
not algorithmic at all.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

