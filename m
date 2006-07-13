Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbWGMSbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbWGMSbp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 14:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWGMSbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 14:31:45 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:45742 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030278AbWGMSbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 14:31:44 -0400
Subject: Re: [PATCH -mm 5/7] add user namespace
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>
In-Reply-To: <m1irm11i2q.fsf@ebiederm.dsl.xmission.com>
References: <20060711075051.382004000@localhost.localdomain>
	 <20060711075420.937831000@localhost.localdomain> <44B3D435.8090706@sw.ru>
	 <m1k66jebut.fsf@ebiederm.dsl.xmission.com> <44B4D970.90007@sw.ru>
	 <m164i2ae3m.fsf@ebiederm.dsl.xmission.com> <44B67C4B.7050009@fr.ibm.com>
	 <m1irm11i2q.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 11:31:31 -0700
Message-Id: <1152815491.7650.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 12:21 -0600, Eric W. Biederman wrote:
> We need a formula for doing incremental development that will allow us to
> make headway while not seeing the entire picture all at once.  The scope
> is just too large.

Definitely.  We need a low-risk development environment where we can put
test-fit pieces together, but also not worry too much of we have to rip
pieces out, or completely change them.

I'm not sure we *need* to rewrite things for review-ability later.  I
think some of us have gotten pretty good at keeping our development in
reviewable bits as we go along.

-- Dave

