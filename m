Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269515AbRIBRh3>; Sun, 2 Sep 2001 13:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269437AbRIBRhT>; Sun, 2 Sep 2001 13:37:19 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:47890 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267534AbRIBRhI>; Sun, 2 Sep 2001 13:37:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Igor Mozetic <igor.mozetic@uni-mb.si>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.9 SMP] alloc_pages failed
Date: Sun, 2 Sep 2001 19:44:15 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
In-Reply-To: <20010902164323Z16375-32383+3004@humbolt.nl.linux.org> <1026233054.999454747@[169.254.198.40]>
In-Reply-To: <1026233054.999454747@[169.254.198.40]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010902173723Z16283-32383+3012@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 2, 2001 07:19 pm, Alex Bligh - linux-kernel wrote:
> I think Daniel's two patches are the wrong way around. IE
> the second (labelled as the first) is the instrumentation
> to differentiate between different kinds of failure, and
> the first (labelled as the second) is the attempt to
> reserve extra pages for atomic allocations to reduce
> 0-order failures.

Yes, indeed - cut & paste error.

--
Daniel
