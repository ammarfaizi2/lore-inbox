Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbWD1XxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbWD1XxT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 19:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWD1XxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 19:53:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14496 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932457AbWD1XxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 19:53:19 -0400
Date: Fri, 28 Apr 2006 16:55:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/6] UML - Small patches for 2.6.17
Message-Id: <20060428165534.6067f5aa.akpm@osdl.org>
In-Reply-To: <200604281601.k3SG11MJ007510@ccure.user-mode-linux.org>
References: <200604281601.k3SG11MJ007510@ccure.user-mode-linux.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> wrote:
>
> These patches are 2.6.17 material.

"remove NULL checks and add some CodingStyle" isn't.  Unless one considers
UML coding style to be a bug, which is an attractive idea ;)

So I gave that one an extra-special look - I'll push it along, thanks.
