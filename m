Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbTIKODW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 10:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbTIKODW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 10:03:22 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5190 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261321AbTIKODU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 10:03:20 -0400
To: insecure@mail.od.ua
Cc: Michael Frank <mhf@linuxmail.org>, Yann Droneaud <yann.droneaud@mbda.fr>,
       fruhwirth clemens <clemens-dated-1063536166.2852@endorphin.org>,
       linux-kernel@vger.kernel.org,
       =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: nasm over gas?
References: <20030904104245.GA1823@leto2.endorphin.org>
	<200309052028.37367.insecure@mail.od.ua>
	<m18yp0o2mq.fsf@ebiederm.dsl.xmission.com>
	<200309100034.58742.insecure@mail.od.ua>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 Sep 2003 08:03:15 -0600
In-Reply-To: <200309100034.58742.insecure@mail.od.ua>
Message-ID: <m1znhbl8ws.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

insecure <insecure@mail.od.ua> writes:

> On Sunday 07 September 2003 21:49, Eric W. Biederman wrote:
> > insecure <insecure@mail.od.ua> writes:
> > > On Friday 05 September 2003 15:59, Michael Frank wrote:
> > > What gives you an impression that anyone is going to rewrite linux in
> > > asm? I _only_ saying that compiler-generated asm is not 'good'. It's
> > > mediocre. Nothing more. I am not asm zealot.
> >
> > I think I would agree with that statement most compiler-generated assembly
> > code is mediocre in general.  At the same time I would add most human
> > generated assembly is poor, and a pain to maintain.
> 
> I had an impression people think gcc generates code which
> is 'mostly good' even compared to handwritted code.
> That is not true (yet).

It is true.  Not when compared to hand optimized code.  But compared
to a day to day churn it is true.  Although I tend to still prefer gcc
2.95 for the code size.  

Eric
