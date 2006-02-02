Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWBBVKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWBBVKo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWBBVKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:10:44 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:25730 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751102AbWBBVKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:10:43 -0500
Message-ID: <43E27549.1000904@fr.ibm.com>
Date: Thu, 02 Feb 2006 22:10:33 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Kirill Korotaev <dev@sw.ru>, Linus Torvalds <torvalds@osdl.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
References: <20060117143258.150807000@sergelap>	<20060117143326.283450000@sergelap>	<1137511972.3005.33.camel@laptopd505.fenrus.org>	<20060117155600.GF20632@sergelap.austin.ibm.com>	<1137513818.14135.23.camel@localhost.localdomain>	<1137518714.5526.8.camel@localhost.localdomain>	<20060118045518.GB7292@kroah.com>	<1137601395.7850.9.camel@localhost.localdomain>	<m1fyniomw2.fsf@ebiederm.dsl.xmission.com>	<43D14578.6060801@watson.ibm.com>	<Pine.LNX.4.64.0601311248180.7301@g5.osdl.org>	<43E21BD0.6000606@sw.ru> <m1d5i5vln3.fsf@ebiederm.dsl.xmission.com>	<43E2249D.8060608@sw.ru> <m1vevxu5bh.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1vevxu5bh.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> If you want the detailed information you can either chroot to an environment
> where the appropriate version of /proc is available.  Or you can modify your
> tools.

did you modify /proc to be able to mount it multiples times on the same
system ?

C.
