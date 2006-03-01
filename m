Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWCAUjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWCAUjq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 15:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWCAUjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 15:39:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:16007 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932239AbWCAUjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 15:39:45 -0500
Subject: Re: Is there any tool that can audit file system activities?
From: Arjan van de Ven <arjan@infradead.org>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4ae3c140603011153i63770328w55038278fea1581@mail.gmail.com>
References: <4ae3c140603011153i63770328w55038278fea1581@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 01 Mar 2006 21:39:43 +0100
Message-Id: <1141245583.3185.56.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-01 at 14:53 -0500, Xin Zhao wrote:
> I want to get some statistics of file system activities. But I don't
> want to write too much code to do this. Instead, I would like to use
> some existing tool.
> 
> Can someone kindly recommend a good tool to do this? Many thanks!


there is a tool called "auditd" and is part of most distros nowadays....


