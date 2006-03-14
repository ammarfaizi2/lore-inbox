Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751897AbWCNOSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbWCNOSf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 09:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751939AbWCNOSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 09:18:34 -0500
Received: from main.gmane.org ([80.91.229.2]:25265 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751897AbWCNOSe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 09:18:34 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?Bj=F8rn_Mork?= <bmork@dod.no>
Subject: Re: Router stops routing after changing MAC Address
Date: Tue, 14 Mar 2006 15:16:30 +0100
Organization: De-bay old Deflagration
Message-ID: <87pskp158h.fsf@obelix.mork.no>
References: <925A849792280C4E80C5461017A4B8A20321F2@mail733.InfraSupportEtc.com>
	<20060313100041.212cee08@localhost.localdomain>
	<Pine.LNX.4.61.0603131513380.5373@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: obelix.mork.no
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:lCXJJ67OEYlZgFIjvOgwAN7WJPo=
Cc: netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:

> Actually, it doesn't make any difference. Changing the IEEE station
> (physical) address is not an allowed procedure even though hooks are
> available in many drivers to do this.

Of course it is.  It's even required to support some obsolete
networking protocols.  You could start with
Documentation/networking/decnet.txt if you don't want to STFW


Bjørn
-- 
I mean, you're always totally wrong.

