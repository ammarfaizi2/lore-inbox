Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269795AbUJGLLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269795AbUJGLLh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 07:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267391AbUJGLLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 07:11:36 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:28816 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S269795AbUJGLK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 07:10:29 -0400
Message-ID: <41652415.A1E987F1@tv-sign.ru>
Date: Thu, 07 Oct 2004 15:10:13 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc3-mm3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Andrew, i think fix-of-stack-dump-in-soft-hardirqs* have problems.
see http://marc.theaimsgroup.com/?l=linux-kernel&m=109681898321430

Do you seeing any flaws in more simple alternative patch?
http://marc.theaimsgroup.com/?l=linux-kernel&m=109687808210397

I sent this description, but haven't got any responce
http://marc.theaimsgroup.com/?l=linux-kernel&m=109688178912849

Oleg.
