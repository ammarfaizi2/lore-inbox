Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282179AbRK1XfZ>; Wed, 28 Nov 2001 18:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282184AbRK1XeA>; Wed, 28 Nov 2001 18:34:00 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:64643 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S282183AbRK1Xc2>; Wed, 28 Nov 2001 18:32:28 -0500
Subject: Coding style - a non-issue
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com>
From: "Peter Waltenberg" <pwalten@au1.ibm.com>
Date: Thu, 29 Nov 2001 09:29:26 +1000
X-MIMETrack: Serialize by Router on d23m0206/23/M/IBM(Release 5.0.8 |June 18, 2001) at
 29/11/2001 10:31:40
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem was solved years ago.

"man indent"

Someone who cares, come up with an indentrc for the kernel code, and get it
into Documentation/CodingStyle
If the maintainers run all new code through indent with that indentrc
before checkin, the problem goes away.
The only one who'll incur any pain then is a code submitter who didn't
follow the rules. (Exactly the person we want to be in pain ;)).


Then we can all get on with doing useful things.

Cheers
Peter

