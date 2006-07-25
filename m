Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWGYT0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWGYT0U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWGYT0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:26:20 -0400
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:16546 "EHLO
	mail.lidskialf.net") by vger.kernel.org with ESMTP id S964839AbWGYT0T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:26:19 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: automated test? (was Re: Linux 2.6.17.7)
Date: Tue, 25 Jul 2006 20:26:15 +0100
User-Agent: KMail/1.9.3
Cc: Michael Krufky <mkrufky@linuxtv.org>,
       David Lang <dlang@digitalinsight.com>,
       Arnaud Patard <apatard@mandriva.com>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Arjan van de Ven <arjan@infradead.org>
References: <20060725034247.GA5837@kroah.com> <44C64FC1.4060501@linuxtv.org> <20060725204236.2afae33d.khali@linux-fr.org>
In-Reply-To: <20060725204236.2afae33d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607252026.16468.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 July 2006 19:42, Jean Delvare wrote:
> Hi Michael,
>
> > The fix can be found here... We'll need this queued up for 2.6.17.8 ...
> >  I have already attached this inline in a prior email, not sure how many
> > people have seen that yet...
> >
> > You can also get it from here:
> >
> > http://linuxtv.org/~mkrufky/stable/2.6.17.y/budget-av-compile-fix.patch
>
> Yes, it fixed the compilation cleanly for me (on both i386 and x86_64).
> I can't test beyond that though, as I don't have that specific hardware.

Great thanks for testing!

As for not having specific hardware for testing, I have the same problem. Its 
a continuing problem with DVB and the source of many regressions :(
