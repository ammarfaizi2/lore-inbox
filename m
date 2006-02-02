Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWBBV00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWBBV00 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWBBV00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:26:26 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6579 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932264AbWBBV0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:26:25 -0500
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, Linus Torvalds <torvalds@osdl.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
References: <20060117143258.150807000@sergelap>
	<20060117143326.283450000@sergelap>
	<1137511972.3005.33.camel@laptopd505.fenrus.org>
	<20060117155600.GF20632@sergelap.austin.ibm.com>
	<1137513818.14135.23.camel@localhost.localdomain>
	<1137518714.5526.8.camel@localhost.localdomain>
	<20060118045518.GB7292@kroah.com>
	<1137601395.7850.9.camel@localhost.localdomain>
	<m1fyniomw2.fsf@ebiederm.dsl.xmission.com>
	<43D14578.6060801@watson.ibm.com>
	<Pine.LNX.4.64.0601311248180.7301@g5.osdl.org>
	<43E21BD0.6000606@sw.ru> <m1d5i5vln3.fsf@ebiederm.dsl.xmission.com>
	<43E2249D.8060608@sw.ru> <m1vevxu5bh.fsf@ebiederm.dsl.xmission.com>
	<43E27549.1000904@fr.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 02 Feb 2006 14:24:41 -0700
In-Reply-To: <43E27549.1000904@fr.ibm.com> (Cedric Le Goater's message of
 "Thu, 02 Feb 2006 22:10:33 +0100")
Message-ID: <m1psm5qwrq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric Le Goater <clg@fr.ibm.com> writes:

> Eric W. Biederman wrote:
>
>> If you want the detailed information you can either chroot to an environment
>> where the appropriate version of /proc is available.  Or you can modify your
>> tools.
>
> did you modify /proc to be able to mount it multiples times on the same
> system ?

Yes.

Eric

