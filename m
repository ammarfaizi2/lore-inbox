Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbUDFSXX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 14:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263944AbUDFSXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 14:23:23 -0400
Received: from main.gmane.org ([80.91.224.249]:42173 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263941AbUDFSXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 14:23:22 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Strip whitespace from EXTRAVERSION?
Date: Tue, 06 Apr 2004 20:23:07 +0200
Message-ID: <yw1xwu4tneyc.fsf@kth.se>
References: <20040406144709.GC16564@oest181.str.klinik.uni-ulm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ti211310a080-13635.bb.online.no
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:AD1scWYqsvsY52DZTeJDfDOs92c=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen Salk <juergen.salk@gmx.de> writes:

> (One could also think about proper quoting to allow whitespace
> in $(EXTRAVERSION), but I'm not so sure if whitespace makes
> much sense in it, anyway.)

Quoting could be a good idea in case the EXTRAVERSION should contain
shell meta-characters.  Why anyone would do such a thing is beyond my
imagination, but who knows?

-- 
Måns Rullgård
mru@kth.se

