Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273141AbRJTMw6>; Sat, 20 Oct 2001 08:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273204AbRJTMws>; Sat, 20 Oct 2001 08:52:48 -0400
Received: from hermes.toad.net ([162.33.130.251]:45467 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S273141AbRJTMwh>;
	Sat, 20 Oct 2001 08:52:37 -0400
Subject: ISO date format [was: Wireless Extension update]
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 20 Oct 2001 08:52:27 -0400
Message-Id: <1003582348.2042.260.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think it's true that there are alternative ISO standards,
otherwise the ISO standard (YYYY-MM-DD) wouldn't be a standard.
The standard applies only to _numerical_ dates, however.

This web page gives a summary:
http://www.cl.cam.ac.uk/~mgk25/iso-time.html

Quotation from the page:
ISO 8601 is only specifying numeric notations and does not cover
dates and times where words are used in the representation. It is
not intended as a replacement for language-dependent worded date
notations such as "24. Dezember 2001" (German) or "February 4, 1995"
(US English).

When writing dates in English I like "4 February 2001" or
"4 Feb 2001" since it reads easily and still puts day, month, year
in a sane order.

I tried to look up the standard itself at the ISO website but
found that I would have to pay 104 Swiss Francs to download the
pdf file.

--
Thomas Hood

--- original message ---

Hi Randy.

>> - * Version :   11      28.3.01
>> + * Version :   12      5.10.01

> nitpicking, i'm sure, but:

> 5.10.01 could have several meanings, usually depending on geographic
> location etc., and there is an ISO standard (8601) which says:

> The international standard date notation is YYYY-MM-DD

There is also another ISO standard (I forget the number) which states
that the international standard date notation is any of...

	DD.MM.YYYY	(European)
	MM/DD/YYYY	(American)
	YYYY-MM-DD	(Japanese)

...with the punctuation character specifying the one in use. I note that
the dates as originally quoted above are clearly consistant with this
standard, so see no problem myself.

Personally, I prefer to use the DD-MMM-YYYY format myself, where MMM in
the three-letter English abbreviation for the month in question, and
there is thus no room for misreading it as something else.

> I'd prefer not to be confused by the '>' quoted notation above,
> although I don't mind the dots instead of hyphens.

I'm so used to > quoting in emails that anything else gets me confused.

Best wishes from Riley.





