Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbTERQRe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 12:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbTERQRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 12:17:34 -0400
Received: from franka.aracnet.com ([216.99.193.44]:9869 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262118AbTERQRd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 12:17:33 -0400
Date: Sun, 18 May 2003 09:30:17 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: ptb@it.uc3m.es, linux-kernel@vger.kernel.org
Subject: Re: recursive spinlocks. Shoot.
Message-ID: <19930000.1053275409@[10.10.2.4]>
In-Reply-To: <200305180921.h4I9LdD13274@oboe.it.uc3m.es>
References: <200305180921.h4I9LdD13274@oboe.it.uc3m.es>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here's a before-breakfast implementation of a recursive spinlock. That
> is, the same thread can "take" the spinlock repeatedly. 

Why?

M.

