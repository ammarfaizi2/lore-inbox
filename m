Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263804AbUFFQts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263804AbUFFQts (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 12:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263817AbUFFQts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 12:49:48 -0400
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:62381 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263804AbUFFQtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 12:49:47 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 2.6] Mousedev - better button handling under load
Date: Sun, 6 Jun 2004 11:49:45 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <200406050249.02523.dtor_core@ameritech.net> <200406060940.21209.dtor_core@ameritech.net> <20040606160245.GA1350@ucw.cz>
In-Reply-To: <20040606160245.GA1350@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406061149.45284.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 June 2004 11:02 am, Vojtech Pavlik wrote:
> On Sun, Jun 06, 2004 at 09:40:20AM -0500, Dmitry Torokhov wrote:
> > On Sunday 06 June 2004 04:58 am, Vojtech Pavlik wrote:
> > > Thanks for this. Can I just pull from your tree, or is there more that I
> > > shouldn't take?
> > > 
> > 
> > I am exporting stuff to my bk tree on as-needed basis so there is nothing
> > extra (and no mousedev changes yet). Do you want button handling changes
> > only or you do also want tapping emulation exported?
> 
> Tapping is fine as well.
> 

OK, when you are ready please do:

	bk pull bk://dtor.bkbits.net/input

-- 
Dmitry
