Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291846AbSBHVgg>; Fri, 8 Feb 2002 16:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291857AbSBHVg1>; Fri, 8 Feb 2002 16:36:27 -0500
Received: from zeus.kernel.org ([204.152.189.113]:45762 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S291846AbSBHVgM>;
	Fri, 8 Feb 2002 16:36:12 -0500
Date: Fri, 8 Feb 2002 19:30:34 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Louis Garcia <louisg00@bellsouth.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Problem with rmap-12c
In-Reply-To: <1013202380.1153.7.camel@tiger>
Message-ID: <Pine.LNX.4.33L.0202081930030.12225-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Feb 2002, Louis Garcia wrote:

> Ok, I've tried rmap-12d and the swaping is better but still worse then
> 12a. One thing I should say is I'm also using Andrews low latency patch.

OK, I'll try to find what is causing the regression in
performance.  I'll try to mail you a patch later this
weekend.

regards,

Rik
-- 
Will hack the VM for food.

http://www.surriel.com/		http://distro.conectiva.com/

