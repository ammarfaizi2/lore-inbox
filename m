Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274135AbRISSoX>; Wed, 19 Sep 2001 14:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274136AbRISSoN>; Wed, 19 Sep 2001 14:44:13 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:59659 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S274135AbRISSn5>;
	Wed, 19 Sep 2001 14:43:57 -0400
Date: Wed, 19 Sep 2001 15:44:13 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix page aging (2.4.9-ac12)
In-Reply-To: <20010919143958.A1466@cs.cmu.edu>
Message-ID: <Pine.LNX.4.33L.0109191543210.8191-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001, Jan Harkes wrote:

> Perhaps the following would be better, just in case anyone sets
> PAGE_AGE_DECL to something other than 1.

Indeed, you're right.  I'll send that one as part of the
next patch (when I'll tackle page_launder).

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

