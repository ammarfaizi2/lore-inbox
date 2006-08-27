Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWH0VqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWH0VqH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 17:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWH0VqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 17:46:06 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63248 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932298AbWH0VqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 17:46:05 -0400
Date: Sun, 27 Aug 2006 23:46:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: scripts/export_report.pl doesn't support O= builds
Message-ID: <20060827214604.GD3574@stusta.de>
References: <20060815021100.GI3543@stusta.de> <1155620540.5724.362.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155620540.5724.362.camel@localhost>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 10:42:20PM -0700, Ram Pai wrote:
> On Tue, 2006-08-15 at 04:11 +0200, Adrian Bunk wrote:
> > scripts/export_report.pl doesn't support O= builds.
> > 
> > Could this be fixed?
> 
> Adrian,
> 	I am assuming you are expecting the functionality integrated in
> 	the kbuild?  

Yes.

> 	If yes, I had the patch submitted long back. I
> 	can resubmit the patch. However Sam felt that having it
>         integrated into the kbuild added little value.

@Sam:
Why not?
I'd consider this a functionality similar to "make namespacecheck".

> RP

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

