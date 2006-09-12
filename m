Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWILPPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWILPPF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWILPPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:15:04 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13783 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030205AbWILPPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:15:02 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Cedric Le Goater <clg@fr.ibm.com>, containers@lists.osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch -mm] update mq_notify to use a struct pid
References: <45019CC3.2030709@fr.ibm.com>
	<m18xktkbli.fsf@ebiederm.dsl.xmission.com>
	<450537B6.1020509@fr.ibm.com>
	<m1u03eacdc.fsf@ebiederm.dsl.xmission.com>
	<45056D3E.6040702@fr.ibm.com>
	<m14pve9qip.fsf@ebiederm.dsl.xmission.com>
	<20060912110559.GD23808@MAIL.13thfloor.at>
Date: Tue, 12 Sep 2006 09:14:02 -0600
In-Reply-To: <20060912110559.GD23808@MAIL.13thfloor.at> (Herbert Poetzl's
	message of "Tue, 12 Sep 2006 13:05:59 +0200")
Message-ID: <m1mz955d8l.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:

> I already did a lot of adjustments to the nfs system, and
> I poked aound in dvb-core before, so I will take a look
> at this in the next few days, at least the switch to the
> kthread api should not be a big deal ...

Ok.  If you can get this it would be great.

To some extent the last holdouts on the kernel_thread api seem to
be the ones that are not trivial to convert :(

Eric
