Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293058AbSB1M2q>; Thu, 28 Feb 2002 07:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293394AbSB1M0Y>; Thu, 28 Feb 2002 07:26:24 -0500
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:8400 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S293393AbSB1MZE>; Thu, 28 Feb 2002 07:25:04 -0500
Date: Thu, 28 Feb 2002 13:24:47 +0100 (MET)
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
X-X-Sender: sithglan@faui02.informatik.uni-erlangen.de
To: Theewara Vorakosit <thvo@ksc.th.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Process name
In-Reply-To: <007d01c1c01a$3b907490$15226c9e@cpe.ku.ac.th>
Message-ID: <Pine.GSO.4.44.0202281323230.20326-100000@faui02.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2002, Theewara Vorakosit wrote:

Have a look in task_struct

current->comm

> Dear All,
>     How can I get process name (same as read from /proc/xxx/cmdline) in
> kernel module?
> Thanks,
> Theewara
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

