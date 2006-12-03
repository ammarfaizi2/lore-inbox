Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759963AbWLCXvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759963AbWLCXvl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 18:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759973AbWLCXvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 18:51:41 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:57287 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1759963AbWLCXvk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 18:51:40 -0500
Date: Mon, 4 Dec 2006 02:51:39 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] introduce put_pid_rcu() to fix unsafe put_pid(vc->vt_pid)
Message-ID: <20061203235118.GA517@oleg>
References: <20061201234826.GA9511@oleg> <20061203130237.761bb15d.akpm@osdl.org> <20061203212926.GA428@oleg> <m1psb0efgf.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1psb0efgf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@tv-sign.ru> writes:
> 
> > Eric, what do you think?
> 
> Anyway with a little luck I should be working on the pid namespace and
> this stuff later today so I will try and send out the proper patch.
> 
> Not that I'm really opposed to this infrastructure but I'd like to
> avoid it until we really need it.

Great! please CC me :)

Oleg.

