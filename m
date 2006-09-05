Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWIENLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWIENLt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 09:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWIENLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 09:11:48 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4101 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932183AbWIENLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 09:11:48 -0400
Date: Tue, 5 Sep 2006 15:11:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: frv compile error in set_pte()
Message-ID: <20060905131140.GC9173@stusta.de>
References: <20060904115845.GP4416@stusta.de> <20060903220657.GG4416@stusta.de> <14367.1157361985@warthog.cambridge.redhat.com> <9812.1157459492@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9812.1157459492@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2006 at 01:31:32PM +0100, David Howells wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > It's a gcc 4.1.1 from ftp.gnu.org.
> 
> If you patch it with the attached patch, does it then work?

Yes.  :-)

> David
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

