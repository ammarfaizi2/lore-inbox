Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbTECS2o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 14:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbTECS2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 14:28:44 -0400
Received: from dialpool-210-214-83-137.maa.sify.net ([210.214.83.137]:32896
	"EHLO softhome.net") by vger.kernel.org with ESMTP id S263364AbTECS2f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 14:28:35 -0400
Date: Sun, 4 May 2003 00:10:10 +0530
From: Balram Adlakha <b_adlakha@softhome.net>
To: Diego Calleja =?iso-8859-1?Q?Garc=EDa?= <diegocg@teleline.es>
Cc: Daniele Pala <dandario@libero.it>, linux-kernel@vger.kernel.org
Subject: Re: make xconfig & qt
Message-ID: <20030503184010.GA940@localhost.localdomain>
References: <3EB41C28.2030007@libero.it> <20030503204109.328cbba2.diegocg@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20030503204109.328cbba2.diegocg@teleline.es>
X-GPG-Fingerprint: A977 433E B71E 2D1C 6114  9F33 F390 527D 70D1 2799
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 03, 2003 at 08:41:09PM +0200, Diego Calleja García wrote:
> On Sat, 03 May 2003 21:44:40 +0200
> Daniele Pala <dandario@libero.it> wrote:
> 
> > Hello.
> > 
> > Sorry for the pretty OT and stupid question, but i just started getting 
> > interested in the linux kernel, so i downloaded kernel 2.5.68. Trying to 
> > run 'make xconfig' i got into the message 'you don't have installed 
> > qt!'...so the xconfig is now dependant from qt? why? what about us poor 
> > guy who only use twm and not kde? isn't qt pretty big and fat? ah well, 
> > falling back to menuconfig...
> 
> make gconfig?
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I think xconfig should be the "X" based one, qconfig should be the qt 
based one and gconfig should be the gtk one. Who maintains the Makefile 
and the scripts in scrips/kconfig?

-- 
