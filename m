Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129803AbQJaXdz>; Tue, 31 Oct 2000 18:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129994AbQJaXdp>; Tue, 31 Oct 2000 18:33:45 -0500
Received: from mailg.telia.com ([194.22.194.26]:50955 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S129803AbQJaXdi>;
	Tue, 31 Oct 2000 18:33:38 -0500
Message-ID: <39FF56E9.C4218507@norran.net>
Date: Wed, 01 Nov 2000 00:34:01 +0100
From: Roger Larsson <roger.larsson@norran.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <Pine.LNX.4.21.0010302325240.16101-100000@imladris.demon.co.uk> <39FE090E.A3AC48F3@timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" wrote:
> 
> David/Alan,
> 
> Andre Hedrick is now the CTO of TRG and Chief Scientist over Linux
> Development.  After talking
> to him, we are going to do our own ring 0 2.4 and 2.2.x code bases for
> the MANOS merge.
> the uClinux is interesting, but I agree is limited.
> 

Jeff,

What would be missed out in this approach:
* Use Montavista "fully" preemtible kernel.
* Using Kernel threads for all services (File, Print, Web, etc.).

/RogerL

--
Home page:
  http://www.norran.net/nra02596/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
