Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbUKACbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbUKACbY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 21:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbUKACbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 21:31:24 -0500
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:23186 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261721AbUKACbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 21:31:22 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.10-rc1-mm2] keyboard / synaptics not working
Date: Sun, 31 Oct 2004 21:31:20 -0500
User-Agent: KMail/1.6.2
Cc: Matthias Hentges <mailinglisten@hentges.net>
References: <200410311903.06927@zodiac.zodiac.dnsalias.org> <200410311955.42507.dtor_core@ameritech.net> <1099274361.10547.4.camel@mhcln03>
In-Reply-To: <1099274361.10547.4.camel@mhcln03>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200410312131.20088.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 31 October 2004 09:01 pm, Matthias Hentges wrote:
> Hello Dmitry,
> 
> Am Mo, den 01.11.2004 schrieb Dmitry Torokhov um 1:55:
> > On Sunday 31 October 2004 01:03 pm, Alexander Gran wrote:
> > > Hi,
> > > 
> > > using 2.6.10-rc1-mm2 my keyboard and synaptics do not work. 2.6.9-rc4-mm1 is 
> > > fine. Both bootlogs are attached.
> > 
> > Do they work if you boot with i8042.noacpi boot option? If so please send me
> > your DSDT (cat /proc/acpi/dsdt > dsdt.hex).
> 
> I had the same problem with 2.6.10-rc1. Using the boot parameter
> i8042.noacpi as you suggested, fixed the keyboard for me.
> 
> I have attached my dsdt.
> Please CC me on replies as I'm not actively reading this list.
> 
> Thanks for your help ;)

Can I get a binary version of it (straight out of /proc/acpi/dsdt) please?
The one you send was converted into C source while I need ASL.

Thanks!

-- 
Dmitry
