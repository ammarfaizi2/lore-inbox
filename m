Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263850AbRFLX2G>; Tue, 12 Jun 2001 19:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263834AbRFLX14>; Tue, 12 Jun 2001 19:27:56 -0400
Received: from marine.sonic.net ([208.201.224.37]:17205 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S263825AbRFLX1m>;
	Tue, 12 Jun 2001 19:27:42 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Tue, 12 Jun 2001 16:27:02 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: threading question
Message-ID: <20010612162701.A4484@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B266CC2.5CB4A029@247media.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2001 at 03:25:54PM -0400, Russell Leighton wrote:
> Any recommendations for alternate threading packages?

Does NSPR use native methods (ie, clone), or just ride on top of pthreads?

What about the gnu threading package?

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
