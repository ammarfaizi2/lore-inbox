Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbULTTi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbULTTi2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 14:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbULTTi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 14:38:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57313 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261628AbULTTh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 14:37:59 -0500
Date: Mon, 20 Dec 2004 11:37:47 -0800
Message-Id: <200412201937.iBKJbl9r012165@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Christoph Lameter <clameter@sgi.com>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] back out CPU clock additions to posix-timers
In-Reply-To: Christoph Lameter's message of  Monday, 20 December 2004 09:00:32 -0800 <Pine.LNX.4.58.0412200857480.6297@schroedinger.engr.sgi.com>
X-Windows: foiled again.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The conservative line is to keep a consistent definition of the interface
> following posix as closely as possible. 

The conservative line for Linux is to not change the interface from 2.6.9,
period.  If Andrew prefers the partial changes, I don't have a strong
objection.  But it is by no means the conservative thing to do.
