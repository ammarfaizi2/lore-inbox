Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265166AbRF0Aq1>; Tue, 26 Jun 2001 20:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265174AbRF0AqS>; Tue, 26 Jun 2001 20:46:18 -0400
Received: from marine.sonic.net ([208.201.224.37]:30264 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S265166AbRF0Ap6>;
	Tue, 26 Jun 2001 20:45:58 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Tue, 26 Jun 2001 17:45:45 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: VM Requirement Document - v0.0
Message-ID: <20010626174544.C3322@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003f01c0fea2$39a64950$0701a8c0@morph>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2001 at 08:43:33PM -0400, Dan Maas wrote:
> (hrm, maybe I could hack up my own manual read-ahead/drop-behind with mmap()
> and memory locking...)

Just to argue portability for a moment (portability on the expected
results, that is, vs APIs).

Would this technique work across a variety of OSes?

Would the recent caching difficulties of the 2.4.* series have handled such
a technique in a reasonable fashion?

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
