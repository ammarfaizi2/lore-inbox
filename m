Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272038AbRIIP7u>; Sun, 9 Sep 2001 11:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272039AbRIIP7k>; Sun, 9 Sep 2001 11:59:40 -0400
Received: from codepoet.org ([166.70.14.212]:63543 "HELO winder.codepoet.org")
	by vger.kernel.org with SMTP id <S272038AbRIIP7Y>;
	Sun, 9 Sep 2001 11:59:24 -0400
Date: Sun, 9 Sep 2001 09:59:45 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Shiva Raman Pandey <shiva@sasken.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Query about Tun/Tap Modules
Message-ID: <20010909095945.A2253@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Shiva Raman Pandey <shiva@sasken.com>, linux-kernel@vger.kernel.org
In-Reply-To: <9ng1q4$or1$1@ncc-z.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ng1q4$or1$1@ncc-z.sasken.com>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.8-ac10-rmk1-rmk2, Rebel-NetWinder(Intel sa110 rev 3), 262.14 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Sep 09, 2001 at 08:58:56PM +0530, Shiva Raman Pandey wrote:
> 
> Q2. What can be other ways, not very complicated  to solve my purpose
> instead of using Tun/Tap.

The network block device can be used via loopback...

 -Erik

--
Erik B. Andersen   email:  andersee@debian.org
--This message was written using 73% post-consumer electrons--
