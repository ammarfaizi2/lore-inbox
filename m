Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135607AbRDXNes>; Tue, 24 Apr 2001 09:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135609AbRDXNei>; Tue, 24 Apr 2001 09:34:38 -0400
Received: from viper.haque.net ([66.88.179.82]:64690 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S135607AbRDXNea>;
	Tue, 24 Apr 2001 09:34:30 -0400
Date: Tue, 24 Apr 2001 09:34:17 -0400 (EDT)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: <ttel5535@artax.karlin.mff.cuni.cz>
cc: "Mike A. Harris" <mharris@opensourceadvocate.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [OFFTOPIC] Re: [PATCH] Single user linux
In-Reply-To: <Pine.LNX.4.21.0104241508370.11387-100000@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.32.0104240932560.29616-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2001, Tomas Telensky wrote:

> :-) Great.
> You and Alex are right - I agree that this is a complete moronism.
>
> But, what I should say to the network security, is that AFAIK in the most
> of linux distributions the standard daemons (httpd, sendmail) are run as
> root! Having multi-user system or not! Why? For only listening to a port
> <1024? Is there any elegant solution?

If your distro is runnign httpd as root you may want to give them a nice
swift kick in the behind. By default apache is configured to run as
nobody.

Dunno about sendmail.

Correct. <1024 requires root to bind to the port.

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

