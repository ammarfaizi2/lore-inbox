Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWDIKjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWDIKjJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 06:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWDIKjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 06:39:09 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21975 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750720AbWDIKjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 06:39:08 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@sw.ru>, herbert@13thfloor.at, sam@vilain.net,
       xemul@sw.ru, James Morris <jmorris@namei.org>
Subject: Re: [PATCH 3/7] uts namespaces: use init_utsname when appropriate
References: <20060407234815.849357768@sergelap>
	<20060408045206.EAA8E19B8FF@sergelap.hallyn.com>
	<m1psjslf1s.fsf@ebiederm.dsl.xmission.com>
	<20060408202701.GA26403@sergelap.austin.ibm.com>
	<m164ljjd70.fsf@ebiederm.dsl.xmission.com>
	<20060409101436.GA20084@infradead.org>
	<20060409102522.GA20276@infradead.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 09 Apr 2006 04:36:25 -0600
In-Reply-To: <20060409102522.GA20276@infradead.org> (Christoph Hellwig's
 message of "Sun, 9 Apr 2006 11:25:22 +0100")
Message-ID: <m1wtdzhw7q.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> And folks, please remove devel@openvz.org from this thead, it's subscribers
> only and gives everyone else nasty bounces.

Odd.  I haven't been getting bounces, and I'm not subscribed.

I wonder if some of the principals in the conversation were given an
explicit exception.  If so that is a subtle pain.

Eric
