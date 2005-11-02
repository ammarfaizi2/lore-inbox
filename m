Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965161AbVKBSNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbVKBSNn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 13:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965166AbVKBSNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 13:13:43 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.123]:36776 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S965161AbVKBSNm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 13:13:42 -0500
Subject: Re: 2.6.14-rt1
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>,
       Florian Schmidt <mista.tapas@gmx.net>,
       john stultz <johnstul@us.ibm.com>, Mark Knecht <markknecht@gmail.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20051102070205.GA1348@elte.hu>
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu>
	 <20051030133316.GA11225@elte.hu>
	 <1130876293.6178.6.camel@cmn3.stanford.edu> <20051102070205.GA1348@elte.hu>
Content-Type: text/plain
Date: Wed, 02 Nov 2005 10:13:04 -0800
Message-Id: <1130955184.21315.6.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-02 at 08:02 +0100, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > The same kernel built for fc3 fails to boot in my Sony laptop. I see 
> > this:
> > 
> > Kernel panic - not syncing: Attempted to kill init!
> 
> why did it panic - no indication of that?

No. It just sits there for a while and then the message I posted
appears. No other thing I can see. 
-- Fernando


