Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262776AbUKXPod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbUKXPod (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 10:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262722AbUKXPmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 10:42:12 -0500
Received: from bgm-24-95-139-53.stny.rr.com ([24.95.139.53]:1158 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262719AbUKXPj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 10:39:58 -0500
Subject: Re: Licensing question
From: Steven Rostedt <rostedt@goodmis.org>
To: DervishD <lkml@dervishd.net>
Cc: Pavel Fedin <sonic_amiga@rambler.ru>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041124113838.GB30870@DervishD>
References: <20041124140433.1d9d1022.sonic_amiga@rambler.ru>
	 <20041124113838.GB30870@DervishD>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Wed, 24 Nov 2004 10:01:58 -0500
Message-Id: <1101308518.32068.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-24 at 12:38 +0100, DervishD wrote:

>     I'm not a lawyer, and I'm not a GPL-expert, neither, but AFAIK,
> if you use GPL code in your project, your code becomes GPLd too.
> 
>     If you use ide-cd driver (or even a part of it), since it is GPL,
> the code that uses it is GPL too. If Aros is not going to distribute
> such source code, then Aros is not allowed to use GPL code.

If you get the permission from the actual authors of the code you use
(in writing) then you don't need to follow the GPL, since the authors
can do whatever they want. But the problem here is, can you track down
all the authors of the said code to get them to write you a permission
slip?

>     Ask FSF for details.

No need to, just ask the authors of the actual code being used.

-- Steve
