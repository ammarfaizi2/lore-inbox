Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264836AbSKEJB0>; Tue, 5 Nov 2002 04:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264838AbSKEJB0>; Tue, 5 Nov 2002 04:01:26 -0500
Received: from web20504.mail.yahoo.com ([216.136.226.139]:24080 "HELO
	web20504.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264836AbSKEJBZ>; Tue, 5 Nov 2002 04:01:25 -0500
Message-ID: <20021105090801.69106.qmail@web20504.mail.yahoo.com>
Date: Tue, 5 Nov 2002 01:08:00 -0800 (PST)
From: vasya vasyaev <vasya197@yahoo.com>
Subject: RE: Machine's high load when HIGHMEM is enabled
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F2DBA543B89AD51184B600508B68D4000F2ECDBA@fmsmsx103.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could you please explain what is this remapping ?
or how it can be named in other words - I cannot find
something like this in BIOS setup menu...


--- "Nakajima, Jun" <jun.nakajima@intel.com> wrote:
> Also try to disable BIOS remapping in the BIOS setup
> menu, if any. I know
> some BIOS that forgot to reset the proper memory
> attribute in the MTRR(s)
> after the remapping.


__________________________________________________
Do you Yahoo!?
HotJobs - Search new jobs daily now
http://hotjobs.yahoo.com/
