Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262583AbVFWPgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbVFWPgk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 11:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbVFWPgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 11:36:39 -0400
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:52446 "EHLO
	gw02.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S262583AbVFWPe3 (ORCPT <rfc822;<linux-kernel@vger.kernel.org>>);
	Thu, 23 Jun 2005 11:34:29 -0400
From: Jan Knutar <jk-lkml@sci.fi>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [ltp] Re: IBM HDAPS Someone interested?
Date: Thu, 23 Jun 2005 18:33:34 +0300
User-Agent: KMail/1.6.2
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>,
       linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
References: <007301c575d9$77decb90$600cc60a@amer.sykes.com> <42B73BB7.4030906@linuxwireless.org> <1119310501.17602.1.camel@mindpipe>
In-Reply-To: <1119310501.17602.1.camel@mindpipe>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200506231833.34423.jk-lkml@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 June 2005 02:35, Lee Revell wrote:

> I was thinking more along the lines of figure out the io port it's
> using, then boot windows, set an IO breakpoint in softice, then drop
> your laptop on the bed or something.

io ports 0x2E, 0x2F and 0xED aren't assigned to anything "known"
on other computers, are they? Someone with windows, softice and
tendency to reach deep insights into life, the universe and everything,
might find it fun to stare at.

