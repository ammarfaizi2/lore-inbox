Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbTDGWoN (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 18:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbTDGWoM (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 18:44:12 -0400
Received: from as6-4-8.rny.s.bonet.se ([217.215.27.171]:33030 "EHLO
	pc2.dolda2000.com") by vger.kernel.org with ESMTP id S263735AbTDGWoJ convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 18:44:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Fredrik Tolf <fredrik@dolda2000.cjb.net>
To: Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] new syscall: flink
Date: Tue, 8 Apr 2003 00:55:43 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <Pine.BSO.4.44.0304062250250.9407-100000@kwalitee.nolab.conman.org> <200304080017.21799.fredrik@dolda2000.cjb.net> <3E91FAF0.4060400@redhat.com>
In-Reply-To: <3E91FAF0.4060400@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304080055.43562.fredrik@dolda2000.cjb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 April 2003 00:25, Ulrich Drepper wrote:
> The use of /proc is growing and you'll find that more than just
> fexecve() will fail if you don't have /proc.

Well, that was no news, but still; you know like... shouldn't it be 
implemented? Or if I put it like this: If I were going to implemented, is 
there any kind of chance to get that public, not least considering that it is 
a new syscall and all?

Fredrik Tolf

