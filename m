Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264490AbRFTCuh>; Tue, 19 Jun 2001 22:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264491AbRFTCuR>; Tue, 19 Jun 2001 22:50:17 -0400
Received: from marine.sonic.net ([208.201.224.37]:30838 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S264490AbRFTCuP>;
	Tue, 19 Jun 2001 22:50:15 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Tue, 19 Jun 2001 19:50:04 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: How to compile on one machine and install on another?
Message-ID: <20010619195003.B30762@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B300933.2090807@nyc.rr.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2001 at 10:23:47PM -0400, John Weber wrote:
> On a related note... is System.map also necessary?  Anyone care to explain 

Debugging.  ksymoops and klogd can both make use of it.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
