Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265138AbSJWS02>; Wed, 23 Oct 2002 14:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265139AbSJWS02>; Wed, 23 Oct 2002 14:26:28 -0400
Received: from cse.ogi.edu ([129.95.20.2]:20172 "EHLO church.cse.ogi.edu")
	by vger.kernel.org with ESMTP id <S265138AbSJWS01>;
	Wed, 23 Oct 2002 14:26:27 -0400
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
References: <Pine.LNX.4.44.0210231102480.1581-100000@blue1.dev.mcafeelabs.com>
From: "Charles 'Buck' Krasic" <krasic@acm.org>
Date: 23 Oct 2002 11:32:32 -0700
In-Reply-To: <Pine.LNX.4.44.0210231102480.1581-100000@blue1.dev.mcafeelabs.com>
Message-ID: <xu4u1jdj9a7.fsf@brittany.cse.ogi.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I see.  Adding async accept/connect would seem to make more sense to me.

-- Buck

Davide Libenzi <davidel@xmailserver.org> writes:

> Maybe my understanding of AIO on Linux is limited but how would you do
> async accept/connect ? Will you be using std poll/select for that, and
> then you'll switch to AIO for read/write requests ?

> - Davide
