Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWBWRym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWBWRym (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWBWRym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:54:42 -0500
Received: from [217.147.92.49] ([217.147.92.49]:4740 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932365AbWBWRyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:54:41 -0500
Date: Thu, 23 Feb 2006 17:53:29 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: dtor_core@ameritech.net, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Extra keycodes
Message-ID: <20060223175328.GA25482@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Several laptops have keys that are intended to show battery status. In 
order to present a consistent view to userspace, it would be nice to 
have a standard keycode to map them to. linux/input.h doesn't currently 
provide anything appropriate. What's the correct way of allocating 
another keycode?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
