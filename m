Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBHAag>; Wed, 7 Feb 2001 19:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129032AbRBHAa1>; Wed, 7 Feb 2001 19:30:27 -0500
Received: from [203.20.159.141] ([203.20.159.141]:54535 "EHLO memim01")
	by vger.kernel.org with ESMTP id <S129027AbRBHAaW>;
	Wed, 7 Feb 2001 19:30:22 -0500
Message-Id: <974A613A43EED311ACBD00508B5EF8C1D66DF9@meexc04.jbwere.com.au>
From: JShaw@jbwere.com.au
To: urban@teststation.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.4.x and oops on 'mount -t smbfs'
Date: Thu, 8 Feb 2001 12:28:59 +1100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resolved!  Running like a bought one now.  Thanks Urban, you are so cool
that you should be in movies.

~NJ!~

> -----Original Message-----
> From:	Urban Widmark [SMTP:urban@teststation.com]
> Sent:	Thursday, February 08, 2001 9:39 AM
> To:	Jim Shaw
> Cc:	linux-kernel@vger.kernel.org
> Subject:	Re: 2.4.x and oops on 'mount -t smbfs'
> 
> On Wed, 7 Feb 2001 JShaw@jbwere.com.au wrote:
> 
> > I've compiled a number of 2.4.1 and 2.4.0 kernels (actually supports the
> 4GB
> > RAM!!!  Yay!!!!), and I have only one more problem to sort out.  Under
> > 2.4.x, the mount completes successfully, but 'ls /net' causes an OOPS:
> 0000.
> 
> Try http://www.hojdpunkten.ac.se/054/samba/smbfs-2.4.1-pre10-cache-2.patch
> 
> Let me know if it works for you or not.
> (patch should be ok with 2.4.0 or 2.4.1)
> 
> /Urban
		      JBWere Limited
			DISCLAIMER

JBWere Limited and its related entities distributing this document and 
each of their respective directors, officers and agents ("the Were Group") 
believe that the information contained in this document is correct and that
any estimates, opinions, conclusions or recommendations contained in this 
document are reasonably held or made as at the time of compilation. However, 
no warranty is made as to the accuracy or reliability of any estimates, 
opinions, conclusions, recommendations (which may change without notice) or 
other information contained in this document and, to the maximum extent 
permitted by law, the Were Group disclaims all liability and responsibility 
for any direct or indirect loss or damage which may be suffered by any recipient 
through relying on anything contained in or omitted from this document.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
