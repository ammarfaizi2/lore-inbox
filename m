Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965084AbWGKHOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbWGKHOt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965231AbWGKHOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:14:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47012 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965084AbWGKHOs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:14:48 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Fernando Luis =?iso-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
Cc: vgoyal@in.ibm.com, akpm@osdl.org, ak@suse.de, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Subject: Re: [PATCH 0/4] stack overflow safe kdump (2.6.18-rc1-i386) try#2
References: <1152597884.2414.53.camel@localhost.localdomain>
Date: Tue, 11 Jul 2006 01:13:40 -0600
In-Reply-To: <1152597884.2414.53.camel@localhost.localdomain> (Fernando Luis
	=?iso-8859-1?Q?V=E1zquez?= Cao's message of "Tue, 11 Jul 2006 15:04:44
 +0900")
Message-ID: <m1u05ohavv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fernando Luis Vázquez Cao <fernando@oss.ntt.co.jp> writes:

> Hi,
>
> I tried to incorporate all the ideas received after the previous post
> (thank you!). In particular I hope the new code is handling the Voyager
> case properly.

Looks good here.

Acked-By: Eric Biederman <ebiederm@xmission.com>

Eric
