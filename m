Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273372AbRJJBnc>; Tue, 9 Oct 2001 21:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273364AbRJJBnY>; Tue, 9 Oct 2001 21:43:24 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:13067 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S273269AbRJJBnS>;
	Tue, 9 Oct 2001 21:43:18 -0400
Date: Tue, 9 Oct 2001 22:43:37 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Xuan Baldauf <xuan--lkml@baldauf.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: dynamic swap prioritizing
In-Reply-To: <3BC373A8.CD94917B@baldauf.org>
Message-ID: <Pine.LNX.4.33L.0110092242350.2847-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2001, Xuan Baldauf wrote:

> Does the linux kernel already implement such an
> optimization? Is it planned?

No and no.  But feel free to try to implement it.

I'm not sure if it would be a win to have the
system do this dynamic swap priority readjustment,
but I wouldn't be surprised if it was, either.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

