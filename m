Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318460AbSGaTNM>; Wed, 31 Jul 2002 15:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318464AbSGaTNM>; Wed, 31 Jul 2002 15:13:12 -0400
Received: from mail.wolnet.de ([213.178.16.8]:22467 "HELO wolnet.de")
	by vger.kernel.org with SMTP id <S318460AbSGaTNL>;
	Wed, 31 Jul 2002 15:13:11 -0400
From: Peter <pk@q-leap.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15688.14227.138201.236063@gargle.gargle.HOWL>
Date: Wed, 31 Jul 2002 21:16:35 +0200
To: Greg KH <greg@kroah.com>
Cc: Peter <pk@q-leap.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, johannes@erdfelt.com
Subject: Re: oops with usb-serial converter
In-Reply-To: <20020731185726.GB21972@kroah.com>
References: <S.0001006613@wolnet.de>
	<20020729173724.GA10153@kroah.com>
	<1027969112.4101.16.camel@irongate.swansea.linux.org.uk>
	<15688.12243.848371.562052@gargle.gargle.HOWL>
	<20020731185726.GB21972@kroah.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: pk@q-leap.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes:
 > On Wed, Jul 31, 2002 at 08:43:31PM +0200, Peter wrote:
 > > 
 > > well, I use lvm, now I could try to compile without lvm support and
 > > boot into single user mode, and see if that works... or could you send
 > > me the function in question (maybe as a patch to 2.4.19-rc3?) - and if
 > > it works then, maybe the 2.4.19 final will include the patch?
 > 
 > Sorry, it's a big change, that will get backported to 2.4.20, but I
 > don't have the time to do it right now (and it's too late for 2.4.19
 > anyway.)  So I don't have a 2.4.19-rc3 patch.

ok, didn't recognize that, so I'll try to do without lvm.

    Peter

-- 
Peter Kruse <pk@q-leap.com>
Q-Leap Networks GmbH
+497071-703171

