Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263932AbUEMPNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263932AbUEMPNS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 11:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263831AbUEMPNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 11:13:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:45440 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264254AbUEMPMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 11:12:00 -0400
Date: Thu, 13 May 2004 08:02:32 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, ebiederm@xmission.com, davidm@hpl.hp.com,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       drepper@redhat.com
Subject: Re: [Fastboot] Re: [announce] kexec for linux 2.6.6
Message-Id: <20040513080232.56116e95.rddunlap@osdl.org>
In-Reply-To: <20040513084931.A6858@infradead.org>
References: <m17jvhoa6g.fsf@ebiederm.dsl.xmission.com>
	<20040512143233.0ee0405a.rddunlap@osdl.org>
	<16546.41076.572371.307153@napali.hpl.hp.com>
	<20040512152815.76280eac.akpm@osdl.org>
	<16546.42537.765495.231960@napali.hpl.hp.com>
	<20040512161603.44c50cec.akpm@osdl.org>
	<20040513053051.A5286@infradead.org>
	<m1lljwsvxr.fsf@ebiederm.dsl.xmission.com>
	<20040513083306.A6631@infradead.org>
	<20040513003727.4026699a.akpm@osdl.org>
	<20040513084931.A6858@infradead.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2004 08:49:31 +0100 Christoph Hellwig wrote:

| On Thu, May 13, 2004 at 12:37:27AM -0700, Andrew Morton wrote:
| > The (old) kexec patch I have here implements the API which is described at
| > http://lwn.net/Articles/15468/.  I doubt if it changed?
| 
| That API looks sane to me.

and current patches are kept at:
  http://developer.osdl.org/rddunlap/kexec/

for review, testing, etc.

--
~Randy
