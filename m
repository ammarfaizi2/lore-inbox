Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265477AbTBBStK>; Sun, 2 Feb 2003 13:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265480AbTBBStK>; Sun, 2 Feb 2003 13:49:10 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15634 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265477AbTBBStJ>; Sun, 2 Feb 2003 13:49:09 -0500
Date: Sun, 2 Feb 2003 18:58:36 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: b_adlakha@softhome.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: what all has changed in ppp?
Message-ID: <20030202185836.B32007@flint.arm.linux.org.uk>
Mail-Followup-To: b_adlakha@softhome.net, linux-kernel@vger.kernel.org
References: <courier.3E3D59B9.00006CAD@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <courier.3E3D59B9.00006CAD@softhome.net>; from b_adlakha@softhome.net on Sun, Feb 02, 2003 at 10:47:37AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 02, 2003 at 10:47:37AM -0700, b_adlakha@softhome.net wrote:
> sorry, I haven't been keeping up with the changes in 2.5, but I can't get 
> pppd to work with 2.5.59, it dies with error code 1 while it works alright 
> with 2.4.20... 

You need to look in the system log files (typically /var/log/messages) to
see why pppd isn't happy.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

