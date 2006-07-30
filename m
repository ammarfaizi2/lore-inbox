Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWG3TcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWG3TcV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 15:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWG3TcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 15:32:21 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:47535 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932462AbWG3TcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 15:32:20 -0400
Date: Sun, 30 Jul 2006 12:32:14 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: jesper.juhl@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] making the kernel -Wshadow clean - fix mconf
Message-Id: <20060730123214.762c09ac.pj@sgi.com>
In-Reply-To: <20060730120631.9ee1ab09.akpm@osdl.org>
References: <200607301830.01659.jesper.juhl@gmail.com>
	<200607301835.35053.jesper.juhl@gmail.com>
	<20060730113416.7c1d8f80.pj@sgi.com>
	<9a8748490607301148q13992d9cr910a1dadb42e11fd@mail.gmail.com>
	<20060730120631.9ee1ab09.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> we can't go and rename up()

True - quite true.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
