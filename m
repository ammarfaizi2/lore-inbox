Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266559AbTGEXVL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 19:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266557AbTGEXU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 19:20:28 -0400
Received: from air-2.osdl.org ([65.172.181.6]:65261 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266554AbTGEXUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 19:20:23 -0400
Date: Sat, 5 Jul 2003 16:35:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lawrence Walton <lawrence@the-penguin.otak.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel oops, netstat -a
Message-Id: <20030705163551.5dcc08d9.akpm@osdl.org>
In-Reply-To: <20030705232647.GA22714@the-penguin.otak.com>
References: <20030705232647.GA22714@the-penguin.otak.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lawrence Walton <lawrence@the-penguin.otak.com> wrote:
>
> Hi I got a oops from netstat -a today, seems innocuous, and repeatable.
>  Happens on both stock 2.5.74, 2.5.74-mm1. 

This should be fixed in 2.5.74-mm2.
