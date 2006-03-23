Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422663AbWCWTD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422663AbWCWTD2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 14:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422664AbWCWTD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 14:03:28 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:48802 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S1422663AbWCWTD1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 14:03:27 -0500
Message-ID: <4422F10B.9080608@bootc.net>
Date: Thu, 23 Mar 2006 19:03:39 +0000
From: Chris Boot <bootc@bootc.net>
User-Agent: Thunderbird 1.5 (X11/20060309)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Libata PATA for 2.6.16
References: <1142869095.20050.32.camel@localhost.localdomain>
In-Reply-To: <1142869095.20050.32.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Alan Cox wrote:
> Can be found at the usual location
> 
> 	http://zeniv.linux.org.uk/~alan/IDE
> 
> Some further small changes and updates, in particular the use of
> platform device class for VLB/ISA/legacy IDE ports and the removal of
> the "no device" special cases from the core.
> 
> Alan

If you're still looking for success reports, I just burned a DVD on 
2.6.16-ide1 just fine. At the final stages of burning I got a few 
messages about the burner not being ready but it kept trying and 
eventually succeeded writing the lead-out. DVD works fine.

Still not tried the pesky tape drive, those tapes I ordered weeks ago 
are still on back order! It is detected properly and claimed by 'st' 
through.

HTH,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
