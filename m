Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbUAAXAC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 18:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbUAAXAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 18:00:02 -0500
Received: from 202.46.136.61.interact.com.au ([202.46.136.61]:46194 "EHLO
	gaston") by vger.kernel.org with ESMTP id S261868AbUAAW77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 17:59:59 -0500
Subject: Re: How to avoid 'lost interrupt' messages post-resume?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1072984022.22058.3.camel@laptop-linux>
References: <1072932095.6722.22.camel@laptop-linux>
	 <1072939036.768.39.camel@gaston>  <1072984022.22058.3.camel@laptop-linux>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1072997992.1188.15.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 02 Jan 2004 09:59:52 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-02 at 06:07, Nigel Cunningham wrote:
> Thanks for the reply.
> 
> I'll look into that area some more.

Let me know what you find, I may be able to help you getting
it right, though it' a bit difficult to do generically in 2.4

Ben.

