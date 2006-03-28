Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWC1XR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWC1XR6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 18:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWC1XR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 18:17:57 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:56205 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S964801AbWC1XR4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 18:17:56 -0500
Subject: Re: [Devel] Re: [RFC] Virtualization steps
From: Sam Vilain <sam@vilain.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jun OKAJIMA <okajima@digitalinfra.co.jp>, devel@openvz.org, akpm@osdl.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, serue@us.ibm.com,
       herbert@13thfloor.at
In-Reply-To: <m1ek0mme5y.fsf@ebiederm.dsl.xmission.com>
References: <4429A17D.2050506@openvz.org>
	 <200603282138.AA00929@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
	 <m1ek0mme5y.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 11:18:05 +1200
Message-Id: <1143587886.6325.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 14:51 -0700, Eric W. Biederman wrote:
> Jun OKAJIMA <okajima@digitalinfra.co.jp> writes:
> 
> > Probably, the biggest problem for now is, Xen patch conflicts with
> > Vserver/OpenVZ patch.
> 
> The implementations are significantly different enough that I don't
> see Xen and any jail patch really conflicting.  There might be some
> trivial conflicts in /proc but even that seems unlikely.

This has been done before,

http://list.linux-vserver.org/archive/vserver/msg10235.html

Sam.

