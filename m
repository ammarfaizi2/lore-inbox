Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270822AbRHSWTk>; Sun, 19 Aug 2001 18:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270821AbRHSWTW>; Sun, 19 Aug 2001 18:19:22 -0400
Received: from ultra.sonic.net ([208.201.224.22]:38513 "EHLO ultra.sonic.net")
	by vger.kernel.org with ESMTP id <S270822AbRHSWTH>;
	Sun, 19 Aug 2001 18:19:07 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Sun, 19 Aug 2001 15:19:13 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
Message-ID: <20010819151913.G30309@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org,
	Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <477033435.998258297@[169.254.45.213]>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2001 at 09:58:17PM +0100, Alex Bligh - linux-kernel wrote:
> This is not the issue; some of use _are_ worried whether or not we
> have enough entropy (and want a read that blocks until sufficient

If you are that worried, shouldn't you be using a hardware generator?

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
