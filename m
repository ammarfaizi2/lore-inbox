Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWIDL6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWIDL6t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 07:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWIDL6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 07:58:49 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:35850 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964836AbWIDL6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 07:58:48 -0400
Date: Mon, 4 Sep 2006 13:58:45 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: frv compile error in set_pte()
Message-ID: <20060904115845.GP4416@stusta.de>
References: <20060903220657.GG4416@stusta.de> <14367.1157361985@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14367.1157361985@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2006 at 10:26:25AM +0100, David Howells wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > I'm getting the follosing compile error in 2.6.18-rc5-mm1 (it might not 
> > be specific to -mm):
> 
> Does your compiler support the 'M' and 'U' constraint modifiers on FRV?

It's a gcc 4.1.1 from ftp.gnu.org.

> David

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


-- 
VGER BF report: H 3.93628e-13
