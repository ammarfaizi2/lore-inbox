Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269375AbUIYSZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269375AbUIYSZY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 14:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269377AbUIYSZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 14:25:24 -0400
Received: from mailfe05.swip.net ([212.247.154.129]:173 "EHLO
	mailfe05.swip.net") by vger.kernel.org with ESMTP id S269375AbUIYSZU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 14:25:20 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Sat, 25 Sep 2004 20:25:06 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Jeremy Allison <jra@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       YOSHIFUJI Hideaki / ???????????? <yoshfuji@linux-ipv6.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6] smbfs & "du" illness
Message-ID: <20040925182506.GA2971@bouh.is-a-geek.org>
Mail-Followup-To: Jeremy Allison <jra@samba.org>,
	Linus Torvalds <torvalds@osdl.org>,
	YOSHIFUJI Hideaki / ???????????? <yoshfuji@linux-ipv6.org>,
	linux-kernel@vger.kernel.org
References: <20040917205422.GD2685@bouh.is-a-geek.org> <Pine.LNX.4.58.0409250929030.2317@ppc970.osdl.org> <20040925171104.GN580@jeremy1> <20040926.024131.06508879.yoshfuji@linux-ipv6.org> <20040925174406.GP580@jeremy1> <Pine.LNX.4.58.0409251054490.2317@ppc970.osdl.org> <Pine.LNX.4.58.0409251108570.2317@ppc970.osdl.org> <20040925182021.GR580@jeremy1>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040925182021.GR580@jeremy1>
User-Agent: Mutt/1.5.6i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le sam 25 sep 2004 à 11:20:21 -0700, Jeremy Allison a tapoté sur son clavier :
> On Sat, Sep 25, 2004 at 11:12:04AM -0700, Linus Torvalds wrote:
> > 
> > Btw, if you want to send bytes instead of blocks, I don't care. The Linux 
> > client can easily do
> > 
> > 	blocks = bytes >> 9;
> > 
> > and I'll be perfectly happy.
> 
> Good - that's all that needs doing.

That's what I submitted, but:

> Happy ?

No, because there's still the minimum of 1MB... What have Microsoft
things to do with unix CIFS extensions ?...

Regards,
Samuel Thibault
