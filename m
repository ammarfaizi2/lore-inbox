Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVARC57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVARC57 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 21:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVARC57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 21:57:59 -0500
Received: from smtpout6.uol.com.br ([200.221.4.197]:60345 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261218AbVARC56
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 21:57:58 -0500
Date: Tue, 18 Jan 2005 00:57:47 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/13] FAT: Return better error codes from vfat_valid_longname()
Message-ID: <20050118025747.GA13820@ime.usp.br>
Mail-Followup-To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <87pt04oszi.fsf@devron.myhome.or.jp> <87llasosxu.fsf@devron.myhome.or.jp> <87hdlgoswe.fsf_-_@devron.myhome.or.jp> <87d5w4osuv.fsf_-_@devron.myhome.or.jp> <20050118020324.GC11257@ime.usp.br> <878y6rlba9.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878y6rlba9.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 18 2005, OGAWA Hirofumi wrote:
> Rogério Brito <rbrito@ime.usp.br> writes:
> > Sorry for the stupid question, but is len guaranteed to be always greater
> > than zero?
> 
> Yes. That "len" was already checked in vfat_add_entry().

Sorry for the stupid question then.


Thanks.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
