Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275709AbRJAXPH>; Mon, 1 Oct 2001 19:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275710AbRJAXO5>; Mon, 1 Oct 2001 19:14:57 -0400
Received: from codepoet.org ([166.70.14.212]:26409 "HELO winder.codepoet.org")
	by vger.kernel.org with SMTP id <S275709AbRJAXOp>;
	Mon, 1 Oct 2001 19:14:45 -0400
Date: Mon, 1 Oct 2001 17:15:16 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] cleanup of partition code
Message-ID: <20011001171516.A28472@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20011001000446.A24245@codepoet.org> <Pine.GSO.4.21.0110010345110.14660-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0110010345110.14660-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.22i
X-Operating-System: Linux 2.4.9-ac10-rmk1, Rebel-NetWinder(Intel sa110 rev 3), 262.14 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Oct 01, 2001 at 04:03:45AM -0400, Alexander Viro wrote:
> 
> 	OK, first of all, it's _not_ an acorn partition table at all.
> It's a garden-variety DOS partition table.
> 
> 	Actually, you've found a rather nasty bug in acorn.c - code in

Looks like your patches were folded into 2.4.10-ac3 -- and I'm pleased
to say that your patch has indeed fixed the problem.  I just scratched
fixing acorn off my when-I-get-around-to-it list.  Thanks!

 -Erik

--
Erik B. Andersen   email:  andersee@debian.org, formerly of Lineo
--This message was written using 73% post-consumer electrons--
