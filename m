Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVG1OAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVG1OAf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 10:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbVG1N6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 09:58:34 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:43529 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261455AbVG1N5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 09:57:04 -0400
Date: Thu, 28 Jul 2005 09:56:58 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] New include file for marking old style api files
Message-ID: <20050728135656.GA9110@tuxdriver.com>
Mail-Followup-To: Jiri Slaby <jirislaby@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <42E8E0C2.5010302@gmail.com> <42E8E29E.5030205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E8E29E.5030205@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 03:50:22PM +0200, Jiri Slaby wrote:
> Jiri Slaby napsal(a):
> 
> >Hi.
> >Do you think, that this would be useful in the kernel tree?
> >I have an idea to mark old drivers, which should I or somebody rewrite.
> >For example drivers/isdn/hisax/gazel.c.

Anyway you could modify this so that people could indicate which
"old" APIs are in use?

Just a thought...

John
-- 
John W. Linville
linville@tuxdriver.com
