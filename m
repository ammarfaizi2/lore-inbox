Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbTFKOJK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 10:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTFKOJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 10:09:09 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:49401 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261450AbTFKOJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 10:09:08 -0400
To: "Auge Mike" <tobe_better@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tracing the kernel...?
References: <Sea2-F643y9Ow5e9HDk00026862@hotmail.com>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Wed, 11 Jun 2003 16:22:30 +0200
In-Reply-To: <Sea2-F643y9Ow5e9HDk00026862@hotmail.com> (Auge Mike's message
 of "Wed, 11 Jun 2003 18:05:59 +0400")
Message-ID: <87llw81yop.fsf@goat.bogus.local>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Auge Mike" <tobe_better@hotmail.com> writes:

> I really want to know how can I trace or debug the kernel and libc? Is
> there any tools and utilities for that?

For tracing take a look at OProfile <http://oprofile.sourceforge.net/>.
For debugging see kgdb at <http://kgdb.sourceforge.net/>.

Regards, Olaf.
