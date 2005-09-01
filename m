Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbVIASYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbVIASYo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 14:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030288AbVIASYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 14:24:44 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5826 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030287AbVIASYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 14:24:43 -0400
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: ncunningham@cyclades.com, Pavel Machek <pavel@ucw.cz>,
       Meelis Roos <mroos@linux.ee>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: reboot vs poweroff
References: <20050901062406.EBA5613D5B@rhn.tartu-labor>
	<1125557333.12996.76.camel@localhost>
	<Pine.SOC.4.61.0509011030430.3232@math.ut.ee>
	<4316F4E3.4030302@drzeus.cx> <1125578897.4785.23.camel@localhost>
	<m1fysoq0p7.fsf@ebiederm.dsl.xmission.com> <43171C02.30402@drzeus.cx>
	<m1aciwpvsz.fsf@ebiederm.dsl.xmission.com>
	<43174643.7040007@drzeus.cx>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 01 Sep 2005 12:23:34 -0600
In-Reply-To: <43174643.7040007@drzeus.cx> (Pierre Ossman's message of "Thu,
 01 Sep 2005 20:19:47 +0200")
Message-ID: <m164tkpryx.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman <drzeus-list@drzeus.cx> writes:
>
> Patch tested and works fine here. You should probably make a note in the
> bugzilla so we don't get a conflicting merge from the ACPI folks.

Thanks.

If I can figure out bugzilla...

> I suppose Nigel should use this function in swsusp2 aswell?

If he is doing the same thing yes.

Eric

