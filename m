Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289002AbSAFSZV>; Sun, 6 Jan 2002 13:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289000AbSAFSZL>; Sun, 6 Jan 2002 13:25:11 -0500
Received: from unknown-1-11.wrs.com ([147.11.1.11]:38826 "EHLO mail.wrs.com")
	by vger.kernel.org with ESMTP id <S289003AbSAFSZB>;
	Sun, 6 Jan 2002 13:25:01 -0500
From: mike stump <mrs@windriver.com>
Date: Sun, 6 Jan 2002 10:24:14 -0800 (PST)
Message-Id: <200201061824.KAA19536@kankakee.wrs.com>
To: dewar@gnat.com, gdr@codesourcery.com
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, paulus@samba.org,
        trini@kernel.crashing.org, velco@fadata.bg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Gabriel Dos Reis <gdr@codesourcery.com>
> Date: 06 Jan 2002 14:22:45 +0100

> Isn't the incriminated construct already outside of C and non-portable?

That has been established and agreed upon.  What we are now into is
pragmatics.  You now have to argue why we should not provide this
feature in some form to users that ask for it.  Love to hear your
ideas.
