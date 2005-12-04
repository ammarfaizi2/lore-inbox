Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbVLDNLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbVLDNLw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 08:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbVLDNLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 08:11:52 -0500
Received: from 35.red-82-159-197.user.auna.net ([82.159.197.35]:29648 "EHLO
	indy.cmartin.tk") by vger.kernel.org with ESMTP id S932216AbVLDNLv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 08:11:51 -0500
From: Carlos =?iso-8859-1?q?Mart=EDn?= <carlos@cmartin.tk>
To: Andi Kleen <ak@suse.de>
Subject: Re: Debug: sleeping function called in atomic context II
Date: Sun, 4 Dec 2005 14:11:29 +0100
User-Agent: KMail/1.8.2
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <200512022132.36626.carlos@cmartin.tk> <200512031351.14458.arnd@arndb.de> <20051203232138.GD14247@wotan.suse.de>
In-Reply-To: <20051203232138.GD14247@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200512041411.29160.carlos@cmartin.tk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 December 2005 00:21, Andi Kleen wrote:
> 
> Please use this patch instead. The previous one had a stupid bug.
 OK, tested x86_64 and it doesn't give any errors.

What is this diff against? patch kept failing, so I had to patch manually.

-- 
Carlos Martín       http://www.cmartin.tk
