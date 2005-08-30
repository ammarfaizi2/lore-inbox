Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbVH3Hg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbVH3Hg3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 03:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVH3Hg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 03:36:29 -0400
Received: from gromit.tds.de ([193.28.97.130]:42690 "EHLO gromit.tds.de")
	by vger.kernel.org with ESMTP id S1751220AbVH3Hg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 03:36:28 -0400
Date: Tue, 30 Aug 2005 09:36:18 +0200
From: Tim Weippert <weiti@security.tds.de>
To: Bongani Hlope <bonganilinux@mweb.co.za>
Cc: Tim Weippert <weiti@security.tds.de>, linux-kernel@vger.kernel.org
Subject: Re: Bad page state on AMD Opteron Dual System with kernel 2.6.13-rc6-git13
Message-ID: <20050830073617.GB4150@pbkg4>
Reply-To: Tim Weippert <weiti@security.tds.de>
References: <20050826165342.GA11796@pbkg4> <20050829052454.GA8172@pbkg4> <20050829102830.GA7604@pbkg4> <200508292204.06032.bonganilinux@mweb.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200508292204.06032.bonganilinux@mweb.co.za>
Organization: TDS Informationstechnologie AG
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2005 at 10:04:05PM +0200, Bongani Hlope wrote:
> On Monday 29 August 2005 12:28 pm, you wrote:
> > Hi,
> >
> 
> 8<
> 
> >
> > Update, with stable 2.6.13. I get nearly the same behavior.
> >
> 
> I haven't tried 2.6.13 yet (still downloading), could you first try this (with 
> yor last working kernel, since you seem to have a problem with 2.6.13)

It's not only with 2.6.13, i think it is with all kernels > 2.6.9 or
.10.

> echo 0 > /proc/sys/kernel/randomize_va_space

Ok, i have set this within my 2.6.13 kernel and will look what happens.

> If this "hides" the problems for you, please take a look at this bug report, 
> and add your details:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=4851

Ok, i will add my details within the next days after examine if this
helps.

bye, 

    tim

-- 

Interpunktion und Orthographie dieser Email ist frei erfunden.
Eine Übereinstimmung mit aktuellen oder ehemaligen Regeln
wäre rein zufällig und ist nicht beabsichtigt.

Tim Weippert <weiti@topf-sicret.org>
http://www.topf-sicret.org/
