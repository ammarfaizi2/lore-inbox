Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSDOTgo>; Mon, 15 Apr 2002 15:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313187AbSDOTgo>; Mon, 15 Apr 2002 15:36:44 -0400
Received: from fly.hiwaay.net ([208.147.154.56]:22282 "EHLO mail.hiwaay.net")
	by vger.kernel.org with ESMTP id <S313060AbSDOTgn>;
	Mon, 15 Apr 2002 15:36:43 -0400
Date: Mon, 15 Apr 2002 14:36:41 -0500
From: Chris Adams <cmadams@hiwaay.net>
To: linux-kernel@vger.kernel.org
Subject: Re: link() security
Message-ID: <20020415143641.A46232@hiwaay.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Organization: HiWAAY Internet Services
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, H. Peter Anvin <hpa@zytor.com> said:
>Not to mention the fact that the single file mailbox design is itself
>flawed.  Mailboxes are fundamentally directories, which news server
>authors quickly realized.

Funny that news server authors realized that storing messages in files
by themselves is a bad idea, while at the same time mail server authors
realized that storing messages together in a single file is a bad idea.
Which one is right?  Both?  Neither?
-- 
Chris Adams <cmadams@hiwaay.net>
Systems and Network Administrator - HiWAAY Internet Services
I don't speak for anybody but myself - that's enough trouble.
