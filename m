Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265814AbUFTDT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265814AbUFTDT2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 23:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265823AbUFTDT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 23:19:28 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:54948 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265815AbUFTDTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 23:19:25 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/11] New set of input patches
Date: Sat, 19 Jun 2004 22:17:29 -0500
User-Agent: KMail/1.6.2
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>
References: <20040618203340.45436.qmail@web81301.mail.yahoo.com> <20040619200532.GB20632@lug-owl.de>
In-Reply-To: <20040619200532.GB20632@lug-owl.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200406192217.29206.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 June 2004 03:05 pm, Jan-Benedict Glaw wrote:
> On Fri, 2004-06-18 13:33:40 -0700, Dmitry Torokhov <dtor_core@ameritech.net>
> wrote in message <20040618203340.45436.qmail@web81301.mail.yahoo.com>:
> > > However, they won't apply onto Linus' tree and cause rejects in a good
> > > number of "interesting" files.
> > 
> > Well, I do not consider it tested enough to be ready for Linus yet :)
> > I am thinking about publushing my input-sysfs bk tree... Will there
> > be an interest in it or you just want a patch against the vanilla 2.6.7?
> > I can do a wholesale patch but splitting my changes from other stuff in
> > Vojtech's tree does not sound very appealing... 
> 
> As I said, I'd love to see a -linus based patch, simply because I
> basically work with exactly this as my base. However, I can also try to
> get another base to start from.
>

Ok, how about this:

http://www.geocities.com/dt_or/input/2_6_7/

00-bk-input.patch.gz and 00-bk-sysfs.patch.gz are pulls from Vojtech's and
Greg's threes diffed against 2.6.7 - that's what I use as a baseline.

The rest of the patches are the ones that I posted earlier. 

-- 
Dmitry
