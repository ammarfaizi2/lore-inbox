Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130029AbRAaH2G>; Wed, 31 Jan 2001 02:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130072AbRAaH15>; Wed, 31 Jan 2001 02:27:57 -0500
Received: from cs.rice.edu ([128.42.1.30]:62144 "EHLO cs.rice.edu")
	by vger.kernel.org with ESMTP id <S130029AbRAaH1q>;
	Wed, 31 Jan 2001 02:27:46 -0500
From: Mohit Aron <aron@cs.rice.edu>
Message-Id: <200101310727.BAA14161@cs.rice.edu>
Subject: Re: gprof cannot profile multi-threaded programs
To: dank@alumni.caltech.edu
Date: Wed, 31 Jan 2001 01:27:42 -0600 (CST)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3A77A4D7.69708BE5@alumni.caltech.edu> from "Dan Kegel" at Jan 30, 2001 09:38:31 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> http://opensource.corel.com/cprof.html
> 
> I haven't used it yet, myself.
> 

I have. cprof is no good - extremely slow and generates a 100MB trace
even with a simple hello world program.



- Mohit

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
