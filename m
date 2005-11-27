Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbVK0TSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbVK0TSj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 14:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbVK0TSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 14:18:38 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:11604 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750848AbVK0TSi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 14:18:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LWp0118x5AK0XdUwy1B0JklNlR3pRUoktw+p3+3pMKH/5v9nJkcDOlqAxlTtcg9fTMNt/FWMbGs/i9/SiHG+DfhBQQVpb4o0xwd1OPglk9DnuVpVIHg7Br7bvpJvKmMwrMKwtmqFohbTWv1AGiScq2AR1REarqMXv8olos8lVVQ=
Message-ID: <9611fa230511271118m3e7e67c1p99c69e7e54dfc1b7@mail.gmail.com>
Date: Sun, 27 Nov 2005 19:18:37 +0000
From: Tarkan Erimer <tarkane@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [BUG]: Software compiling occasionlly hangs under 2.6.15-rc1/rc2 and 2.6.15-rc1-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1133118747.2853.40.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9611fa230511250312i55d0b872x82b8c33b4d2973e4@mail.gmail.com>
	 <1132917564.7068.41.camel@laptopd505.fenrus.org>
	 <9611fa230511270317led5b915h7daae3ef1287f86d@mail.gmail.com>
	 <1133092701.2853.0.camel@laptopd505.fenrus.org>
	 <9611fa230511271108m46389ee6w7ec6b5b40b1e23dd@mail.gmail.com>
	 <1133118747.2853.40.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/05, Arjan van de Ven <arjan@infradead.org> wrote:
> hmm this in theory could also be a thermal issue...

By the way, I'm using IBM R40 machine. Maybe it should be a thermal
issue, as you mentioned. But interestingly, this issue never happens
with 2.6.14 and downwards.
