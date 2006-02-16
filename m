Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWBPXHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWBPXHZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 18:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWBPXHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 18:07:25 -0500
Received: from pool-71-161-48-129.clppva.east.verizon.net ([71.161.48.129]:39363
	"EHLO ccs.covici.com") by vger.kernel.org with ESMTP
	id S1750778AbWBPXHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 18:07:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17397.1447.3634.270271@ccs.covici.com>
Date: Thu, 16 Feb 2006 18:07:18 -0500
From: John covici <covici@ccs.covici.com>
To: Matt Reuther <mreuther@umich.edu>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Problems with SB Live using 2.6.15.3
In-Reply-To: <20060216175722.4g6kyjpes4w040ok@engin.mail.umich.edu>
References: <20060216175722.4g6kyjpes4w040ok@engin.mail.umich.edu>
X-Mailer: VM 7.17 under Emacs 22.0.50.2
Reply-To: covici@ccs.covici.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

However, I could not run alsamixer or amixr -- they always gave me
those errors.

on Thursday 02/16/2006 Matt Reuther(mreuther@umich.edu) wrote
 > This isn't really an answer to your problem, but I had a problem with 
 > SB Live! when I upgraded my kernel from 2.6.15.3 to 2.6.15.4. On 
 > boot-up, alsactl restore couldn't enable my sound because of wrong or 
 > duplicate names in the settings file. I ended up running alsamixer and 
 > alsactl store to correct it.
 > 
 > Matt
 > -
 > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > Please read the FAQ at  http://www.tux.org/lkml/

-- 
Your life is like a penny.  You're going to lose it.  The question is:
How do
you spend it?

         John Covici
         covici@ccs.covici.com
