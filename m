Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbVDWRyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVDWRyB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 13:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbVDWRyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 13:54:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15841 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261635AbVDWRyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 13:54:00 -0400
Date: Sat, 23 Apr 2005 13:53:52 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: ismail donmez <ismail.donmez@gmail.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: gcc-4.0.0 final miscompiles net/ipv4/devinet.c:devinet_sysctl_register()
Message-ID: <20050423175352.GU17420@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <200504230952.j3N9qm6W012596@harpo.it.uu.se> <2a4f155d05042310375d99994b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a4f155d05042310375d99994b@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2005 at 08:37:23PM +0300, ismail d?nmez wrote:
> Whats the bugzilla # for this so others can track it?

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=21167
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=21173

	Jakub
