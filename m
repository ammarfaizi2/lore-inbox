Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272950AbTG3QSx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 12:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272955AbTG3QSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 12:18:53 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8898 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S272950AbTG3QSw (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 12:18:52 -0400
Date: Wed, 30 Jul 2003 18:18:39 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: John Bradford <john@grabjohn.com>, Riley@Williams.Name,
       Linux-Kernel@vger.kernel.org
Subject: Re: [2.6 patch] let broken drivers depend on BROKEN{,ON_SMP}
Message-ID: <20030730161839.GB19356@fs.tum.de>
References: <200307300911.h6U9BH2f000813@81-2-122-30.bradfords.org.uk> <20030730104421.GC28767@fs.tum.de> <20030730160403.GF12849@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730160403.GF12849@louise.pinerecords.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 06:04:03PM +0200, Tomas Szepe wrote:
> > [bunk@fs.tum.de]
> > 
> > If a _user_ of a stable kernel notices "it doesn't even compile" this 
> > gives a very bad impression of the quality of the Linux kernel.
> 
> The keyword in this sentence is "stable."
> Could you maybe come up with this again at around 2.6.40? :)

The first stable kernel of the 2.6 kernel series will be 2.6.0.

My patch or omething similar should go into 2.6 before 2.6.0 .
Whether 2.6.0-test2 or 2.6.0-test15 is the right time is a different 
question - as long as it's before 2.6.0 .

> Tomas Szepe <szepe@pinerecords.com>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

