Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261638AbTCYIrP>; Tue, 25 Mar 2003 03:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261654AbTCYIrP>; Tue, 25 Mar 2003 03:47:15 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2820 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261638AbTCYIrO>; Tue, 25 Mar 2003 03:47:14 -0500
Date: Tue, 25 Mar 2003 08:58:21 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       sensors@stimpy.netroedge.com
Subject: Re: [PATCH] i2c driver changes for 2.5.66
Message-ID: <20030325085821.B16443@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	sensors@stimpy.netroedge.com
References: <10485563141404@kroah.com> <10485563161165@kroah.com> <20030325085505.A16443@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030325085505.A16443@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Tue, Mar 25, 2003 at 08:55:05AM +0000
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 08:55:05AM +0000, Russell King wrote:
> Are you sure that "IOC/IOMD" is a good name to stick in sysfs?
> s|/|,| would probably be a good idea.

Gah, ignore that comment.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

