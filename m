Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264462AbTIDBiO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 21:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbTIDBiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 21:38:14 -0400
Received: from mail0-96.ewetel.de ([212.6.122.96]:41157 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S264462AbTIDBiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 21:38:09 -0400
Date: Thu, 4 Sep 2003 03:38:03 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: David Schwartz <davids@webmaster.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: Driver Model
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKAENCGDAA.davids@webmaster.com>
Message-ID: <Pine.LNX.4.44.0309040317120.8368-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, David Schwartz wrote:

> In other words, if you want to distribute the Linux kernel, you must
> license it under the terms of the GPL. You may not impose additional
> restrictions because if you do, you're not causing it to be distribute
> under the terms of "this License".

Correct.

> It does cover use.

In section 0:

Activities other than copying, distribution and modification are not
covered by this License; they are outside its scope.

> Specifically, it permits unrestriced use. If you
> received GPL'd code, you have the unrestricted right to use it. That's
> what section 2b says.

No, section 2b gives you the the right to copy, distribute, and modify
the code (as the license only covers those rights, as per section 0) and 
no restrictions may be placed on those specific rights.

> Non-issue. I'm talking about your rights to *use* the kernel.

Well, I'm not buying the argument that the GPL has anything to say
about usage.

> You must not be reading the same GPL I am. Can you please cite to me the
> section that requires derived works to be placed under the GPL. I can't
> find it.

You quoted it yourself. 2b) 

    b) You must cause any work that you distribute or publish, that in
    whole or in part contains or is derived from the Program or any
    part thereof, to be licensed as a whole at no charge to all third
    parties under the terms of this License.

"work that ... is derived from the Program or any part thereof"

> But that's not what it does. It prevents you from using the kernel in
> certain ways. The GPL does not permit such usage restrictions.

Lots of GPL'ed programs refuse to be used in certain ways. For example,
fetchmail will refuse to run with a world-readable .fetchmailrc file.

> It also restricts your ability to create and use derived works. The GPL 
> similarly does not permit such restrictions.

That it does not, and such a restriction would violate the GPL, I'd
agree to that.

> You only have that right (in the United States) if the GPL_ONLY stuff is
> *not* a copyright enforcement scheme.

How can it be that? It does not restrict copying nor distribution
nor modification.

People here are saying that it's more of a hint to people that they
better think hard and ask a lawyer before implementing non-GPL'ed
kernel modules.

I think you bringing the DMCA into this shows an interesting aspect
of that law: who gets to say what is a copyright enforcement scheme
and what is not?

-- 
Ciao,
Pascal

