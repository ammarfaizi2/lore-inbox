Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbTEMOtA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 10:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbTEMOtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 10:49:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21265 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261315AbTEMOs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 10:48:56 -0400
Date: Tue, 13 May 2003 15:59:18 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Stacy Woods <stacyw@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Bugs sitting in the NEW state for more than 3 weeks
Message-ID: <20030513155918.A15172@flint.arm.linux.org.uk>
Mail-Followup-To: Stacy Woods <stacyw@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <3EC0FBB9.30103@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EC0FBB9.30103@us.ibm.com>; from stacyw@us.ibm.com on Tue, May 13, 2003 at 10:05:45AM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 10:05:45AM -0400, Stacy Woods wrote:
> 428  Drivers    Serial     rmk@arm.linux.org.uk
                             ^^^^^^^^^^^^^^^^^^^^
> Not all serial ports listed in /proc/interrupts & /proc/ioports

Bug#:    428       Submitter:   spstarr@sh0n.net (Shawn Starr)
Owner:   zwane@holomorphy.com (Zwane Mwaikambo)

What is the email address in your report supposed to indicate?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

