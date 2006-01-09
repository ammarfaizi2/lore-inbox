Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWAIPPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWAIPPH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 10:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWAIPPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 10:15:07 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:210 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932349AbWAIPPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 10:15:05 -0500
Subject: Re: [OT?] Re: Why the DOS has many ntfs read and write driver,but
	the linux can't for a long time
From: Lee Revell <rlrevell@joe-job.com>
To: Yaroslav Rastrigin <yarick@it-territory.ru>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>, andersen@codepoet.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200601091751.27405.yarick@it-territory.ru>
References: <174467f50601082354y7ca871c7k@mail.gmail.com>
	 <200601091403.46304.yarick@it-territory.ru>
	 <1136814862.9957.5.camel@mindpipe>
	 <200601091751.27405.yarick@it-territory.ru>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 10:15:03 -0500
Message-Id: <1136819703.9957.10.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-09 at 17:51 +0300, Yaroslav Rastrigin wrote:
> Hi, Lee,
> On 9 January 2006 16:54, you wrote:
> > > 
> > 
> > Where are the bug reports?  You didn't expect these to just fix
> > themselves did you?
> Been there, done that. Bugreport about malfunctioning (due to ACPI) 3c556 in IBM ThinkPad T20 was looked at once in a few months without any progress, 
> and I've finally lost track of it after changing hardware. In more than a year this problem wasn't solved, so I'm assuming bugreports aren't so effective.
> 2200BG ping and packet loss problem was reported in ipw2200-devel mailing list recently (by another user), and the only answer was 
> "Switch to version 1.0.0" (which is tooo old and missing needed features and bugfixes, so recommentation was unacceptable). So I'm assuming addressing 
> developers directly is not too effective either. 
> Two other options I see are to debug/fix it by myself and try to stimulate others monetarily. First option isn't really affordable for me , 
> so I'm trying to research second. 

Bug reports certainly are effective, but if no one else can reproduce
your problem then obviously it can't be fixed.

A bug report that gets no responses is a good sign that you need to
provide more information or work a little harder to debug it yourself.

Lee

