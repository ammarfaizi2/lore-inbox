Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263307AbTEMIwk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 04:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbTEMIwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 04:52:40 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10253 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263307AbTEMIwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 04:52:39 -0400
Date: Tue, 13 May 2003 10:03:03 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org, hch@infradead.org, gregkh@kroah.com,
       linux-security-module@wirex.com
Subject: Re: [PATCH] Early init for security modules
Message-ID: <20030513100303.A5900@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org, hch@infradead.org,
	gregkh@kroah.com, linux-security-module@wirex.com
References: <20030512200309.C20068@figure1.int.wirex.com> <20030512200804.K19432@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030512200804.K19432@figure1.int.wirex.com>; from chris@wirex.com on Mon, May 12, 2003 at 08:08:04PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 08:08:04PM -0700, Chris Wright wrote:
> This is just the arch specific linker bits for the early initialization
> for security modules patch.  Does this look sane for this arch?

Looks sane.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

