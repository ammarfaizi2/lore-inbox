Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129543AbQLGPcB>; Thu, 7 Dec 2000 10:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129744AbQLGPbk>; Thu, 7 Dec 2000 10:31:40 -0500
Received: from gemini.tcg-software.com ([208.221.13.100]:42252 "HELO
	gemini.tcg-software.com") by vger.kernel.org with SMTP
	id <S129413AbQLGPbX>; Thu, 7 Dec 2000 10:31:23 -0500
X-Lotus-FromDomain: TCG-SOFTWARE
From: "Rajiv Majumdar" <rmajumda@tcg-software.com>
To: linux-kernel@vger.kernel.org
Message-ID: <652569AE.0050738A.00@gemini.tcg-software.com>
Date: Thu, 7 Dec 2000 17:25:08 +0530
Subject: related to pthread
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi

I am trying to write a multithreaded tcp/ip daemon using the pthread
interface. The server compiles well but during an exec it gives the
following error message : "Pthread internal error : message :
__libc__reinit() failed" and creates a core dump.

I would highly appreciate any help.

Rajiv


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
