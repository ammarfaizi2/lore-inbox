Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262719AbRFGSYj>; Thu, 7 Jun 2001 14:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262729AbRFGSY3>; Thu, 7 Jun 2001 14:24:29 -0400
Received: from [213.96.124.18] ([213.96.124.18]:43755 "HELO dardhal")
	by vger.kernel.org with SMTP id <S262719AbRFGSYR>;
	Thu, 7 Jun 2001 14:24:17 -0400
Date: Thu, 7 Jun 2001 20:24:53 +0000
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jldomingo@crosswinds.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
Message-ID: <20010607202453.A2263@dardhal.mired.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3B1F2BFE.28E7CCF0@idb.hist.no>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 07 June 2001, at 09:23:42 +0200,
Helge Hafting wrote:

> Derek Glidden wrote:
> > 
> > Helge Hafting wrote:
> [...]
> The machine froze 10 seconds or so at the end of the minute, I can
> imagine that biting with bigger swap.
> 
Same behavior here with a Pentium III 600, 128 MB RAM and 128 MB of swap.
Filled mem and swap with the infamous glob() "bug" (ls ../*/.. etc.), made
swapoff, and the machine kept very responsive except for the last 10-15
seconds before swapoff ends.

Even scrolling complex pages with Mozilla 0.9 worked smoothly :).

-- 
José Luis Domingo López
Linux Registered User #189436     Debian GNU/Linux Potato (P166 64 MB RAM)
 
jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
jdomingo AT internautas DOT   org  => Spam at your own risk

