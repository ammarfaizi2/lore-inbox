Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286310AbRL0Pmm>; Thu, 27 Dec 2001 10:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286312AbRL0Pmc>; Thu, 27 Dec 2001 10:42:32 -0500
Received: from hera.cwi.nl ([192.16.191.8]:23763 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S286310AbRL0PmW>;
	Thu, 27 Dec 2001 10:42:22 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 27 Dec 2001 15:42:20 GMT
Message-Id: <UTC200112271542.PAA121704.aeb@cwi.nl>
To: kaih@khms.westfalen.de, linux-kernel@vger.kernel.org
Subject: Re: Configure.help editorial policy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Most disk sizes are an unholy mixture of the two
> that deserves a stake through the heart,
> where 1 GB = 1,024,000,000 bytes.

"Are"??

I see several good people spout this particular type of nonsense
here. If I interpret "are" to mean that that is the unit
disk manufacturers use, then it is false - as far as I know
no manufacturer uses this.

Let us look at Maxtor. They are so friendly to give disk size
as part of the type.
Maxtor 91728D8 - 17280442368 bytes, 17280 MB, 17.2 GB
Maxtor 93652U8 - 36529274880 bytes, 36529 MB, 36.5 GB
Maxtor 96147H6 - 61473226752 bytes, 61473 MB, 61.4 GB

You see that the number of GB claimed by the manufacturer is
just (number of megabytes)/1000.
There is no 2.4% difference that could justify your strange claim.

All disk manufacturers always use decimal.
And this has been true for many years.

Andries
