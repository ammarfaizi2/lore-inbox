Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbVKSS36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVKSS36 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 13:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbVKSS36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 13:29:58 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:64983 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750736AbVKSS36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 13:29:58 -0500
Subject: Re: Does Linux support powering down SATA drives?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marc Perkel <marc@perkel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <437F63C1.6010507@perkel.com>
References: <437F63C1.6010507@perkel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 19 Nov 2005 19:01:27 +0000
Message-Id: <1132426887.19692.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-11-19 at 09:41 -0800, Marc Perkel wrote:
> Trying to save power consumption. I have a backup drive that is used 
> only once a day to back up the main drive. So - why should I run it more 
> that 10 minutes a day? What I'd like to do is keep it in an off state 
> and then at night power it on, mount it up, do the backup, unmount it, 
> and shut it down. Can I do that?


SATA not yet, USB you could however.

