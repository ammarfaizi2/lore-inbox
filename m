Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264197AbUEHJOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264197AbUEHJOG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 05:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263580AbUEHJOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 05:14:06 -0400
Received: from main.gmane.org ([80.91.224.249]:15061 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264197AbUEHJOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 05:14:03 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: module-licences / tainting the kernel
Date: Sat, 08 May 2004 11:14:24 +0200
Message-ID: <yw1xzn8j8emn.fsf@kth.se>
References: <200405080957.57286.aweiss@informatik.hu-berlin.de> <1084003417.3843.9.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 161.80-203-29.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:0KQve04aWc+51B/swaCrrgAIwAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> writes:

>> Would it be possible to let e.g. LPGL-licenced kernel-modules be loaded 
>> legally?
>
> there are 2 angles here:
> 1) there already is "GPL with additional rights" which LGPL is just one
> form of

What about BSD?  That's open enough for me.

> and
> 2) if you mix LGPL with GPL (eg kernel), the LGPL license itself says it
> autoconverts to GPL, so you can't even have a LGPL module *loaded*.
> (Not saying that your source can't be LGPL but when you link it into the
> kernel at runtime it turns GPL)

That would only make a difference if you have the intention of
distributing /proc/kcore.

-- 
Måns Rullgård
mru@kth.se

