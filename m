Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312799AbSDBFql>; Tue, 2 Apr 2002 00:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312803AbSDBFqb>; Tue, 2 Apr 2002 00:46:31 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64560 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S312799AbSDBFqT>; Tue, 2 Apr 2002 00:46:19 -0500
To: Alexander Viro <viro@math.psu.edu>
Cc: Max <ertzog@bk.ru>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Syscall by name
In-Reply-To: <Pine.GSO.4.21.0204011449560.10933-100000@weyl.math.psu.edu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 Apr 2002 22:39:52 -0700
Message-ID: <m1r8lyu09j.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> writes:

> On Sun, 24 Mar 2002, Max wrote:
> 
> > I saw several months ago here a message, telling about a new system call,
> > that returnes a syscall number, by its name. So, if a module registers a
> > new syscall dynamically, it is automatically seen by everybody.
> > Is this idea dead?
> 
> It's stillborn - modules are not (and will not be) allowed to add syscalls.
> Case closed.

How does vmware count in this?

Eric
