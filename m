Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264626AbTHXBeA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 21:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264634AbTHXBd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 21:33:59 -0400
Received: from kom-pc-aw.ethz.ch ([129.132.66.20]:11751 "HELO
	kom-pc-aw.ethz.ch") by vger.kernel.org with SMTP id S264624AbTHXBd6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 21:33:58 -0400
Date: Sun, 24 Aug 2003 03:33:57 +0200
From: Arno Wagner <wagner@tik.ee.ethz.ch>
To: Diego Calleja Garc?a <diegocg@teleline.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.6.0-test3: dmesg buffer still too small
Message-ID: <20030824013357.GA5810@tik.ee.ethz.ch>
References: <20030823151336.GB4266@tik.ee.ethz.ch> <20030823224255.34fee3a0.diegocg@teleline.es> <20030824010539.GA5682@tik.ee.ethz.ch> <20030824031235.1780c622.diegocg@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030824031235.1780c622.diegocg@teleline.es>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 24, 2003 at 03:12:35AM +0200, Diego Calleja Garc?a wrote:
> El Sun, 24 Aug 2003 03:05:39 +0200 Arno Wagner <wagner@tik.ee.ethz.ch> escribi?:
> 
> > Not displayed by "make menuconfig" and "make config" 
> > unfortunately.
> 
> I just copied it from menuconfig. Visible if you've enabled DEBUG_KERNEL.

Indeed. Thanks for the info!

Arno

-- 
Arno Wagner, Communication Systems Group, ETH Zuerich, wagner@tik.ee.ethz.ch
GnuPG:  ID: 1E25338F  FP: 0C30 5782 9D93 F785 E79C  0296 797F 6B50 1E25 338F
----
For every complex problem there is an answer that is clear, simple, 
and wrong. -- H L Mencken
