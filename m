Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286635AbRLVCmZ>; Fri, 21 Dec 2001 21:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286646AbRLVCmP>; Fri, 21 Dec 2001 21:42:15 -0500
Received: from sushi.toad.net ([162.33.130.105]:37867 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S286635AbRLVCly>;
	Fri, 21 Dec 2001 21:41:54 -0500
Subject: Re: Configure.help editorial policy
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 21 Dec 2001 21:42:02 -0500
Message-Id: <1008988924.803.0.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I favor switching to the use of KiB for 1024 bytes, etc.,
because I favor precision.  Precise speech aids precise
thought.

One argument against was that 'KB' has been used ambiguously
in the past, so we should continue to use it ambiguously
in the future (for backward compatibility).  However, I
don't think that our descendents brought up with "KiB"
will have trouble reading their grandparents' computer
manuals written with "KB".  "KiB" was chosen because of its
similarity to "KB".  They'll be able to say: "Hey, no wonder
computers used to crash back in the twentieth century.  They
didn't know the difference between a kilobyte and a kibibyte!"
And they wouldn't be entirely wrong, either.

The other argument against the new terminology was that
when you speak the long forms, they sound funny.  So
all you people think that "kilobyte" and "megabyte" don't
sound funny?  A priori, "kibi" is no more ridiculous than
"kilo".

I think that the folks that thought of these prefixes were
rather clever, choosing names similar to the decimal prefixes,
yet easy to distinguish and still faily easy to pronounce.

The only thing wanting is a set of nouns for describing powers
of 2^10.  I suggest:
   one thousband = 1,024
   one milbion   = 1,048,576
   one bilbion   = 1,073,741,824
   one trilbion  = 1,099,511,627,776
   etc.

Now what was the name of Fat Albert's friend who always said
"Haybee manbee, passbee mebee the ballbee!" ?


