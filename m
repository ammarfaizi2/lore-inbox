Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262005AbRESXdH>; Sat, 19 May 2001 19:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262007AbRESXc6>; Sat, 19 May 2001 19:32:58 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:38572 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262009AbRESXcs>;
	Sat, 19 May 2001 19:32:48 -0400
Message-ID: <3B070299.54F6599E@mandrakesoft.com>
Date: Sat, 19 May 2001 19:32:41 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ben LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD 
 w/info-PATCH]device arguments from lookup)
In-Reply-To: <Pine.GSO.4.21.0105191904490.7162-100000@weyl.math.psu.edu> <3B070257.5632A059@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Notice also a "metadata miscdev" solves the problem of passing options
> on open -- just pass those options to the miscdev before you open it...

to be more clear, "it" == the data device, not the metadata miscdev

-- 
Jeff Garzik      | "Do you have to make light of everything?!"
Building 1024    | "I'm extremely serious about nailing your
MandrakeSoft     |  step-daughter, but other than that, yes."
