Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289530AbSAJQ1z>; Thu, 10 Jan 2002 11:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289531AbSAJQ1p>; Thu, 10 Jan 2002 11:27:45 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:11529 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289530AbSAJQ13>;
	Thu, 10 Jan 2002 11:27:29 -0500
Date: Thu, 10 Jan 2002 14:27:05 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Rodrigo Souza de Castro <rcastro@ime.usp.br>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pager_daemon removal
In-Reply-To: <20020110161035.GC1780@vinci>
Message-ID: <Pine.LNX.4.33L.0201101426110.2985-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2002, Rodrigo Souza de Castro wrote:

> Comments?

You're not allowed to renumber sysctl defines, it's ok
to remove the VM_PAGER_DAEMON thing, but the following
defines should stay the same number ...

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

