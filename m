Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbTIFNxi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 09:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTIFNxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 09:53:37 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:38975 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261268AbTIFNxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 09:53:37 -0400
Date: Sat, 6 Sep 2003 14:52:36 +0100
From: Dave Jones <davej@redhat.com>
To: war <war@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_AGP_INTEL Question.
Message-ID: <20030906135236.GA22545@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, war <war@lucidpixels.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.56.0309060935320.10980@p500>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0309060935320.10980@p500>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 06, 2003 at 09:36:42AM -0400, war wrote:
 > I was wondering when/how often do updates take place to this driver?

rarely. The X folks occasionally send me patches for 2.6, I believe
they send them to Alan/Marcelo for 2.4 too.

 > I have an Intel i875 chipset and was wondering when it would be possible
 > to use AGPGART/etc (to use GLX/3D stuff).

2.6 supports the 875, even though it isn't listed in Kconfig.
I'll go fix that up.  Dunno about 2.4

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
