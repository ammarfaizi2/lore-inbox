Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbTJTTA3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 15:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbTJTTA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 15:00:29 -0400
Received: from [65.172.181.6] ([65.172.181.6]:7065 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262766AbTJTTA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 15:00:28 -0400
Date: Mon, 20 Oct 2003 12:00:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Mario \"jorge\" Di Nitto" <jorge78@inwind.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8-mm1 failure..
Message-Id: <20031020120029.78a69465.akpm@osdl.org>
In-Reply-To: <200310202008.23294.jorge78@inwind.it>
References: <200310202008.23294.jorge78@inwind.it>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mario \"jorge\" Di Nitto" <jorge78@inwind.it> wrote:
>
> I've just tryed 2.6.0-test8-mm1 and I've got this failure at boot (last 100 
>  lines of /var/log/messages):

Please set CONFIG_KALLSYMS=y and resend the oops trace so we can
see where it crashed, thanks.
