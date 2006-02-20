Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbWBTOuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbWBTOuQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWBTOuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:50:15 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:52179 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1030264AbWBTOuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:50:13 -0500
Message-ID: <43F9E93D.7024167A@tv-sign.ru>
Date: Mon, 20 Feb 2006 19:07:25 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 1/2] copy_process: cleanup bad_fork_cleanup_sighand
References: <43F9E841.FD560455@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> 
>
> [PATCH 1/2] copy_process: cleanup bad_fork_cleanup_sighand

Err, sorry, should be "[PATCH 1/4]". The same for the next "2/2"
patch in series.

Oleg.
