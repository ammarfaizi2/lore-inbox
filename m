Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268714AbRHSSqi>; Sun, 19 Aug 2001 14:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270676AbRHSSq3>; Sun, 19 Aug 2001 14:46:29 -0400
Received: from prop.sonic.net ([208.201.224.193]:1872 "EHLO prop.sonic.net")
	by vger.kernel.org with ESMTP id <S268714AbRHSSqK>;
	Sun, 19 Aug 2001 14:46:10 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Sun, 19 Aug 2001 11:46:23 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
Message-ID: <20010819114623.D30309@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0108182137250.5646-100000@imladris.rielhome.conectiva>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2001 at 09:38:21PM -0300, Rik van Riel wrote:
> So how are you going to feed /dev/urandom on your firewall ??
> (which has no keyboard, program or disk activity)

Hardware random generator?

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
