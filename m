Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267267AbSKPLeT>; Sat, 16 Nov 2002 06:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267268AbSKPLeS>; Sat, 16 Nov 2002 06:34:18 -0500
Received: from khms.westfalen.de ([62.153.201.243]:42428 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S267267AbSKPLeS>; Sat, 16 Nov 2002 06:34:18 -0500
Date: 16 Nov 2002 11:47:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8$ya-6IXw-B@khms.westfalen.de>
In-Reply-To: <3DD5DC77.2010406@pobox.com>
Subject: Re: Why can't Johnny compile?
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <3DD5D93F.8070505@kegel.com> <3DD5D93F.8070505@kegel.com> <3DD5DC77.2010406@pobox.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jgarzik@pobox.com (Jeff Garzik)  wrote on 16.11.02 in <3DD5DC77.2010406@pobox.com>:

> Most of the stuff that doesn't compile (or link) is typically stuff that
> is lesser used, or never used.  A lot of the don't-compile complaints
> seem to be vocal-minority type complaints or "why can't I build _every_
> module in the kernel?" complaints.  Ref allmodconfig, above.

So maybe there should be a list of config symbols to turn off (preferrably  
automatically) after allmodconfig or so, a "we know this is broken" list.

MfG Kai
