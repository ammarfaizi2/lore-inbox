Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261947AbREPNeM>; Wed, 16 May 2001 09:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261950AbREPNeC>; Wed, 16 May 2001 09:34:02 -0400
Received: from pD9004B0D.dip.t-dialin.net ([217.0.75.13]:17634 "HELO
	schottelius.org") by vger.kernel.org with SMTP id <S261947AbREPNdu>;
	Wed, 16 May 2001 09:33:50 -0400
Message-ID: <3B0281AB.10B6BD4E@pcsystems.de>
Date: Wed, 16 May 2001 15:33:31 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Philip Blundell <philb@gnu.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: parport problems with devfs
In-Reply-To: <3B027E46.5095E8BB@pcsystems.de> <E1501Og-0007EH-00@kings-cross.london.uk.eu.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm..seems you are exactly right!

Sorry for that wrong though!

Nico

Philip Blundell wrote:

> >I attached the problem occured with parport and devfs.
> >I don't exactly know where the problem in the parport source
> >is. If someone has a patch for it, I will test it.
>
> I don't think this is a bug.  You need to load the `lp' module.
>
> p.

