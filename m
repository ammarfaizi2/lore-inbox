Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWBFUl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWBFUl2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWBFUl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:41:27 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:14267 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964805AbWBFUl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:41:26 -0500
Date: Mon, 6 Feb 2006 14:41:21 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: [RFC][PATCH 17/20] usb: Fixup usb so it works with pspaces.
Message-ID: <20060206204121.GM11887@sergelap.austin.ibm.com>
References: <m1u0bcl1ai.fsf_-_@ebiederm.dsl.xmission.com> <m1psm0l170.fsf_-_@ebiederm.dsl.xmission.com> <m1lkwol133.fsf_-_@ebiederm.dsl.xmission.com> <m1hd7cl0yp.fsf_-_@ebiederm.dsl.xmission.com> <m1d5i0l0ua.fsf_-_@ebiederm.dsl.xmission.com> <m18xsol0p9.fsf_-_@ebiederm.dsl.xmission.com> <m14q3cl0mk.fsf_-_@ebiederm.dsl.xmission.com> <m1zml4jlzk.fsf_-_@ebiederm.dsl.xmission.com> <m1vevsjlxa.fsf_-_@ebiederm.dsl.xmission.com> <m1r76gjlua.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1r76gjlua.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

Just how many of these patches would have been unnecessary given your
tref patchset?

thanks,
-serge
