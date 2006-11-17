Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932929AbWKQP7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932929AbWKQP7A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 10:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932935AbWKQP7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 10:59:00 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:11454 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932929AbWKQP67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 10:58:59 -0500
Subject: Re: 2.6.19-rc6-rt0, -rt YUM repository
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Walker <dwalker@mvista.com>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20061116220733.GA17217@elte.hu>
References: <20061116153553.GA12583@elte.hu>
	 <1163694712.26026.1.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611162212110.21141@frodo.shire>
	 <1163713469.26026.4.camel@localhost.localdomain>
	 <20061116220733.GA17217@elte.hu>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 10:58:36 -0500
Message-Id: <1163779116.6953.38.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-16 at 23:07 +0100, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > [...] Should we start a known regression list?
> 
> please resend the bugs that still trigger for you with 2.6.19-rt0.

I'm working with the developers of the 64Studio distro who are
attempting to ship a stable -rt kernel so I have access to lots of good
bug reports.  Oops on boot is by far the most common.  I'll post details
once we've retested with 2.6.19-rt0.

Lee

