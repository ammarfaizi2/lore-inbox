Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTI3Ild (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 04:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbTI3Ild
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 04:41:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:17670 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261180AbTI3Ilc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 04:41:32 -0400
Date: Tue, 30 Sep 2003 01:37:26 -0700
From: "David S. Miller" <davem@redhat.com>
To: Urban Widmark <Urban.Widmark@enlight.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: buggy changes to fs/smbfs/inode.c
Message-Id: <20030930013726.592e538e.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0309262054370.13663-100000@cola.local>
References: <20030925225116.433e1c53.davem@redhat.com>
	<Pine.LNX.4.44.0309262054370.13663-100000@cola.local>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Sep 2003 21:12:16 +0200 (CEST)
Urban Widmark <Urban.Widmark@enlight.net> wrote:

> I guess what I want is an OLD_TO_NEW_UID macro. How does this look?

That looks great, I'll push this off to Linus.
