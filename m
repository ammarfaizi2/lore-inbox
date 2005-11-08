Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965609AbVKHADq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965609AbVKHADq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 19:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965610AbVKHADq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 19:03:46 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:8394 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S965609AbVKHADp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 19:03:45 -0500
Date: Mon, 7 Nov 2005 16:03:32 -0800
From: Paul Jackson <pj@sgi.com>
To: Dick <dm@chello.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SIGALRM ignored
Message-Id: <20051107160332.0efdf310.pj@sgi.com>
In-Reply-To: <loom.20051107T183059-826@post.gmane.org>
References: <loom.20051107T183059-826@post.gmane.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> trap 'echo bla' 14 ; /bin/kill -14 $$

This is unlikely to be a Linux kernel internal development
issue, which is what this "linux-kernel@vger.kernel.org"
list is focused on.  If I knew a good list to recommend
you ask this question on off the top of my head, I'd
recommend it.  Nothing jumps to mind.  Thought I'd at
least let you know that you might not get much help here,
and encourage you to research other possible resources.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
