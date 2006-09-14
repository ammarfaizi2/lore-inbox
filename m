Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWINBkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWINBkX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 21:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWINBkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 21:40:23 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:4281 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1751328AbWINBkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 21:40:23 -0400
Date: Thu, 14 Sep 2006 11:40:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Zachary Amsden <zach@vmware.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael A Fetterman <Michael.Fetterman@cl.cam.ac.uk>
Subject: Re: Assignment of GDT entries
Message-Id: <20060914114022.8f16c36e.sfr@canb.auug.org.au>
In-Reply-To: <4508A191.1060203@vmware.com>
References: <450854F3.20603@goop.org>
	<1158175001.3054.7.camel@laptopd505.fenrus.org>
	<4508681E.3070708@goop.org>
	<4508711B.6060905@vmware.com>
	<1158183322.16902.8.camel@localhost.localdomain>
	<4508A191.1060203@vmware.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2006 17:25:53 -0700 Zachary Amsden <zach@vmware.com> wrote:
>
> It is worth fixing, just not a high 
> priority.  I had a patch that fixed both APM and PnP at one time, but it 
> is covered with mold and now looks like a science experiment.  Shall I 
> apply disinfectant?

Yes, please.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
