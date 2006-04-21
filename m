Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWDUDQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWDUDQo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 23:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWDUDQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 23:16:44 -0400
Received: from quechua.inka.de ([193.197.184.2]:54160 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932148AbWDUDQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 23:16:43 -0400
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: Which process is associated with process ID 0 (swapper)
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <44483668.7030109@gmail.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1FWm8P-0000sM-00@calista.inka.de>
Date: Fri, 21 Apr 2006 05:16:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikado <mikado4vn@gmail.com> wrote:
> Single packet is created by multiple processes? Can you show me some
> examples?

cork to combine headers with sendfile content? Well, I dont think those
cases are important :)

Gruss
Bernd
