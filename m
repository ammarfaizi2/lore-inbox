Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280190AbRLTGrN>; Thu, 20 Dec 2001 01:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282805AbRLTGrD>; Thu, 20 Dec 2001 01:47:03 -0500
Received: from marine.sonic.net ([208.201.224.37]:12840 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S280190AbRLTGq5>;
	Thu, 20 Dec 2001 01:46:57 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Wed, 19 Dec 2001 22:46:52 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: aio
Message-ID: <20011220064651.GB32678@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org, linux-aio@kvack.org
In-Reply-To: <20011219224717.A3682@redhat.com> <20011219.213910.15269313.davem@redhat.com> <20011220005803.E3682@redhat.com> <20011219.220040.55725223.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011219.220040.55725223.davem@redhat.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2001 at 10:00:40PM -0800, David S. Miller wrote:
> No I'm not talking about phttpd nor zeus, I'm talking about the guy
> who did the hacks where he'd put the http headers + content into a
> seperate file and just sendfile() that to the client.
> 
> I forget what his hacks were named, but there certainly was a longish
> thread on this list about it about 1 year ago if memory serves.


Would that be Fabio Riccardi's X15 stuff?

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
