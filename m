Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbTLKBAb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 20:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbTLKBAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 20:00:31 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:17156
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S264265AbTLKBAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 20:00:30 -0500
Subject: RE: Linux GPL and binary module exception clause?
From: Rob Love <rml@tech9.net>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Maciej Zenczykowski <maze@cela.pl>,
       David Schwartz <davids@webmaster.com>,
       Jason Kingsland <Jason_Kingsland@hotmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10312101449260.3805-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10312101449260.3805-100000@master.linux-ide.org>
Content-Type: text/plain
Message-Id: <1071104315.6072.260.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Wed, 10 Dec 2003 19:58:35 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-12-10 at 17:59, Andre Hedrick wrote:

> I suggest asking FSF how they play with GPL+another license.
> They will tell you GPL can not co-exist, period.

They cannot coexist _at the same time in the same agreement_, but a
single work can be licensed out hundreds of times in different ways.

If I hold the copyright on something, I can provide a different license
to each licensee of the product if I so choose.  That is pretty common,
in fact.

The GPL and some-other-license are incompatible in the sense that  you
cannot put another license on _top_ of the GPL in the _same_ licensing
agreement.  But you are free to license something in the GPL _or_ BSD
_or_ some-evil-EULA, and that is what Linus et al are talking about, and
_not_ what the FSF means when they say that some license is incompatible
with the GPL.

	Robert Love


