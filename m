Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264327AbTKZVDb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 16:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264328AbTKZVDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 16:03:31 -0500
Received: from pizda.ninka.net ([216.101.162.242]:7319 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264327AbTKZVDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 16:03:30 -0500
Date: Wed, 26 Nov 2003 13:02:54 -0800
From: "David S. Miller" <davem@redhat.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Fire Engine??
Message-Id: <20031126130254.010440e5.davem@redhat.com>
In-Reply-To: <20031126202216.GA13116@thunk.org>
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel>
	<20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel>
	<p73fzgbzca6.fsf@verdi.suse.de>
	<20031126113040.3b774360.davem@redhat.com>
	<20031126202216.GA13116@thunk.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Nov 2003 15:22:16 -0500
"Theodore Ts'o" <tytso@mit.edu> wrote:

> I believe what Andi was suggesting was if there was **no** processes
> that are currently requesting timestamps, then we can dispense with
> taking the timestamp.

You can predict what the arguments will be for the user's
recvmsg() system call at the time of packet reception?  Wow,
show me how :)
