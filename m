Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286486AbRLUAAn>; Thu, 20 Dec 2001 19:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286485AbRLUAAe>; Thu, 20 Dec 2001 19:00:34 -0500
Received: from theirongiant.zip.net.au ([61.8.0.198]:39557 "EHLO
	theirongiant.zip.net.au") by vger.kernel.org with ESMTP
	id <S286483AbRLUAAT>; Thu, 20 Dec 2001 19:00:19 -0500
Date: Fri, 21 Dec 2001 10:59:52 +1100
From: CaT <cat@zip.com.au>
To: Chris Ricker <kaboom@gatech.edu>
Cc: Troels Walsted Hansen <troels@thule.no>,
        "'David S. Miller'" <davem@redhat.com>,
        World Domination Now! <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
Message-ID: <20011220235952.GA3506@zip.com.au>
In-Reply-To: <007401c189a7$50f6cd60$0300000a@samurai> <Pine.LNX.4.33.0112201651370.26999-100000@verdande.oobleck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0112201651370.26999-100000@verdande.oobleck.net>
User-Agent: Mutt/1.3.24i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 04:55:55PM -0700, Chris Ricker wrote:
> > I wish... Neither Samba 2.2.2 nor the bleeding edge 3.0alpha11 includes
> > the word "sendfile" in the source at least. :( Wonder why the sendfile
> > patches where never merged...
> 
> The only real-world source I've noticed actually using sendfile() are some
> of the better ftp daemons (such as vsftpd).

proftpd uses it also.

-- 
CaT        - A high level of technology does not a civilisation make.
