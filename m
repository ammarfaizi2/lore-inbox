Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWDDVqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWDDVqu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 17:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWDDVqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 17:46:50 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:27154 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750712AbWDDVqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 17:46:50 -0400
Date: Tue, 4 Apr 2006 23:46:47 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: regression in kbiuld with O=
Message-ID: <20060404214647.GA13586@mars.ravnborg.org>
References: <20060404152430.GG27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404152430.GG27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 04:24:30PM +0100, Al Viro wrote:
> make O=../test kernel/sched.o produces kernel/sched.o is source tree
> now.  AFAICS, breakage started in 06300b21f4c79fd1578f4b7ca4b314fbab61a383
> (kbuild: support building individual files for external modules).
Thanks. I will take a look tomorrow.

	Sam
