Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129930AbQL2TRj>; Fri, 29 Dec 2000 14:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130061AbQL2TRa>; Fri, 29 Dec 2000 14:17:30 -0500
Received: from office.mandrakesoft.com ([195.68.114.34]:47603 "HELO
	touba.mandrakesoft.com") by vger.kernel.org with SMTP
	id <S129930AbQL2TRU>; Fri, 29 Dec 2000 14:17:20 -0500
To: Sourav Sen <sourav@csa.iisc.ernet.in>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: How to write patches
In-Reply-To: <Pine.SOL.3.96.1001229234454.12681A-100000@kohinoor.csa.iisc.ernet.in>
From: Daouda LO <daouda@mandrakesoft.com>
Date: 29 Dec 2000 19:48:41 +0000
In-Reply-To: Sourav Sen's message of "Fri, 29 Dec 2000 23:52:05 +0530 (IST)"
Message-ID: <m2wvcjc8km.fsf@touba.mandrakesoft.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sourav Sen <sourav@csa.iisc.ernet.in> writes:

> Hi,
> 
> This question may seem naive, but can anyone tell me if there is any
> structured way of writing patches? 
> 
> I mean suppose I want to implement some
> kernel mechanism, and I define my data structures etc. and made most of
> the code as loadable  module to start with, but still I am having to
> change some parts of the kernel code at the development time, and I
> want to make that change using patches, so that I do not have to browse
> thru the files to change the code as I debug. 
> 
> Is there any structured way of doing this?

have a look at:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0011.2/0151.html
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
