Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281487AbRKTX0t>; Tue, 20 Nov 2001 18:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281489AbRKTX0j>; Tue, 20 Nov 2001 18:26:39 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:14328 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S281487AbRKTX0d>; Tue, 20 Nov 2001 18:26:33 -0500
Date: Tue, 20 Nov 2001 15:19:50 -0800
From: Chris Wright <chris@wirex.com>
To: Miguel Maria Godinho de Matos <Astinus@netcabo.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Loop.c File !!!!
Message-ID: <20011120151950.B12208@figure1.int.wirex.com>
Mail-Followup-To: Miguel Maria Godinho de Matos <Astinus@netcabo.pt>,
	linux-kernel@vger.kernel.org
In-Reply-To: <EXCH01SMTP011vDfrwV0000fda4@smtp.netcabo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <EXCH01SMTP011vDfrwV0000fda4@smtp.netcabo.pt>; from Astinus@netcabo.pt on Tue, Nov 20, 2001 at 11:12:02PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Miguel Maria Godinho de Matos (Astinus@netcabo.pt) wrote:
> The problem is the following:
> 
> I AM A NEWBIE!!! 
> 
> Well i had some questions about the linux kernel compilation and some of you 
> gave me some real goos answeres, however, there is an issue which keeps 
> buzzing my head and that i can't understand!
> 
> Some one told me i should edit the loop.c file and even tried to explained me 
> why but i couldn't understand.

the code in loop.c references a function deactivate_page() which was
removed from the kernel.  for more details, read this thread:

http://marc.theaimsgroup.com/?t=100500866500001&w=2&r=1

cheers,
-chris

