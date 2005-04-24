Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262280AbVDXHfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbVDXHfI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 03:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVDXHfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 03:35:07 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:25195 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262280AbVDXHfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 03:35:04 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.12-rc3
Date: Sun, 24 Apr 2005 02:35:01 -0500
User-Agent: KMail/1.8
Cc: Pavel Machek <pavel@ucw.cz>, Petr Baudis <pasky@ucw.cz>,
       Linus Torvalds <torvalds@osdl.org>
References: <20050421120327.GA13834@elf.ucw.cz> <20050423230648.GE13222@pasky.ji.cz> <20050424072100.GA1908@elf.ucw.cz>
In-Reply-To: <20050424072100.GA1908@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504240235.01614.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 April 2005 02:21, Pavel Machek wrote:
> Without cherypicking, I just can't pull from linux-git into
> linux-good. Ever. linux-git contains some changes that just can not go
> anywhere. (Like for example czech-ucw-defkeymap.map)

I was using quilt on top of BK and I think it will be good idea to do the
same with git... When I think that my patches are ready for other people
to see I cherry-pick and commit them into $SCM and push into externally-
visible tree.

-- 
Dmitry
