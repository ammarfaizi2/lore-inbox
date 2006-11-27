Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757083AbWK0WmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757083AbWK0WmR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 17:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757734AbWK0WmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 17:42:17 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19407 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1757081AbWK0WmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 17:42:17 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Containers <containers@lists.osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix the binary ipc and uts namespace sysctls.
References: <m1hcwlmqmp.fsf@ebiederm.dsl.xmission.com>
	<20061127202211.GB26108@MAIL.13thfloor.at>
Date: Mon, 27 Nov 2006 15:40:35 -0700
In-Reply-To: <20061127202211.GB26108@MAIL.13thfloor.at> (Herbert Poetzl's
	message of "Mon, 27 Nov 2006 21:22:11 +0100")
Message-ID: <m1y7pwldi4.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:

> the linux banner needs some attention too, when I get
> around, I'll send a patch for that ...

In what sense?

I have trouble seeing the banner printed at bootup as being problematic.

Eric
