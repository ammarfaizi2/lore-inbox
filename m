Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130154AbRAKMG6>; Thu, 11 Jan 2001 07:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129842AbRAKMGs>; Thu, 11 Jan 2001 07:06:48 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:3423
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129610AbRAKMGj>; Thu, 11 Jan 2001 07:06:39 -0500
Date: Thu, 11 Jan 2001 13:06:32 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Hans Grobler <grobh@sun.ac.za>
Cc: "Karsten Hopp (Red Hat)" <Karsten.Hopp@sap.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-ac6: drivers/net/rcpci45.c typo
Message-ID: <20010111130632.H27620@jaquet.dk>
In-Reply-To: <3A5D9F29.4274AD6B@sap.com> <Pine.LNX.4.30.0101111358140.30013-100000@prime.sun.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101111358140.30013-100000@prime.sun.ac.za>; from grobh@sun.ac.za on Thu, Jan 11, 2001 at 01:59:31PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2001 at 01:59:31PM +0200, Hans Grobler wrote:
> Yes we know about this one. This is a bug that was killed, and then came
> back to life. We're still trying to figure out how... :)
> 
I feel that I must step up and claim responsibility here: The patch is
mine and I apparently messed it up. I will get back with a better one
this evening.

Rasmus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
