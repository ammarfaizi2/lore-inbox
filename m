Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261460AbSJDD6L>; Thu, 3 Oct 2002 23:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261464AbSJDD6L>; Thu, 3 Oct 2002 23:58:11 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:13215 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261460AbSJDD6L>; Thu, 3 Oct 2002 23:58:11 -0400
Date: Fri, 4 Oct 2002 00:03:31 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200210040403.g9443Vu03329@devserv.devel.redhat.com>
To: bidulock@openss7.org
cc: linux-kernel@vger.kernel.org
Subject: Re: export of sys_call_table
In-Reply-To: <mailman.1033691043.6446.linux-kernel2news@redhat.com>
References: <20021003153943.E22418@openss7.org> <20021003221525.GA2221@kroah.com> <20021003222716.GB14919@suse.de> <1033684027.1247.43.camel@phantasy> <20021003233504.GA20570@suse.de> <20021003235022.GA82187@compsoc.man.ac.uk> <mailman.1033691043.6446.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Right, it's buggered on Red Hat's kernel. Not really a problem; they
>> have a bugzilla and it's not big deal to redirect users there.
> 
> Been there, done that:
> 
> 	https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=74902
> 
> Interested parties are welcome to join the fray.

Bugzilla is not a place for "fray". If you want to get flamed,
I can oblige without screwing Bugzilla.

Also, if you are a provider of a binary-only crapware which wants
to override syscalls, there's one very important document for
you to see: it's called Fig.1.

GPLed code has no problem linking with sys_call_table.

-- Pete
