Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbVAUSw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbVAUSw3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 13:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbVAUSw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 13:52:28 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:48397 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262467AbVAUSwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 13:52:18 -0500
Date: Fri, 21 Jan 2005 19:52:11 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Dave Olien <dmo@osdl.org>
Subject: Re: device-mapper: remove unused bs_bio_init()
Message-ID: <20050121185211.GN3209@stusta.de>
References: <20050121175828.GG10195@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121175828.GG10195@agk.surrey.redhat.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 05:58:28PM +0000, Alasdair G Kergon wrote:

> Remove unused bs_bio_init().
>...

This is also done within a bigger patch Dave Olien sent just yesterday.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

