Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131477AbRDXIjp>; Tue, 24 Apr 2001 04:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131820AbRDXIjf>; Tue, 24 Apr 2001 04:39:35 -0400
Received: from mail.informatik.uni-ulm.de ([134.60.68.63]:61728 "EHLO
	mail.informatik.uni-ulm.de") by vger.kernel.org with ESMTP
	id <S131477AbRDXIj0>; Tue, 24 Apr 2001 04:39:26 -0400
Message-ID: <3AE53B9E.1C52266C@student.uni-ulm.de>
Date: Tue, 24 Apr 2001 10:38:54 +0200
From: Markus Schaber <markus.schaber@student.uni-ulm.de>
Organization: University of Ulm
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: de,de-DE,en
MIME-Version: 1.0
To: mirabilos <eccesys@topmail.de>
CC: esr@thyrsus.com, "Giacomo A. Catenazzi" <cate@dplanet.ch>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Request for comment -- a better attribution system
In-Reply-To: <20010421114942.A26415@thyrsus.com> <3AE1E77C.AF1402F4@dplanet.ch> <20010421155509.B4185@thyrsus.com> <01c901c0cb28$45b67650$de00a8c0@homeip.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

mirabilos wrote:

> > > It whould nice also if we include the type of the license (GPL,...).
> > > This for a fast parsing (and maybe also to replace the few lines
> > > of license)
> > Is there any kernel code that isn't GPLed?
> It must not, due to the GPL viral effect.

Well, would it be possible to create some module under LGPL, and then
have included it into the kernel? Maybe it needs to maintain the LGPL
version out of the kernel, and transform a copy to the GPL before
submitting?

Or what about using a "twin-licence" that states "you can apply GPL or
$another_licence, whichever you want"?

And what about real "public domain" software, where the author gave up
all rights? (AFAIK, this is not legally possible in the German copyright
laws, as you can't licence uses that'll be invented in the future).

markus, not a lawyer
-- 
Markus Schaber -- http://www.schabi.de/ -- ICQ: 22042130
+-------------------------------------------------------------+
| Allgemeine Sig-Verletzung 0815/4711  <nicht OK> <Erbrechen> |
+-------------------------------------------------------------+
