Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271239AbTGWTgt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 15:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271241AbTGWTgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 15:36:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32773 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S271239AbTGWTgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 15:36:18 -0400
Date: Wed, 23 Jul 2003 20:51:22 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Dave Lawrence <dgl@integrinautics.com>, linux-kernel@vger.kernel.org
Subject: Re: compact flash IDE hot-swap summary please
Message-ID: <20030723205122.B439@flint.arm.linux.org.uk>
Mail-Followup-To: Andre Hedrick <andre@linux-ide.org>,
	Dave Lawrence <dgl@integrinautics.com>,
	linux-kernel@vger.kernel.org
References: <3F1ECFDD.D561D861@integrinautics.com> <Pine.LNX.4.10.10307231211060.13376-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.10.10307231211060.13376-100000@master.linux-ide.org>; from andre@linux-ide.org on Wed, Jul 23, 2003 at 12:12:47PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 12:12:47PM -0700, Andre Hedrick wrote:
> You never remove the "TrueIDE" from the cable so the bridge chip saves
> you.  Go try it with standard media and you will see different.

There is no IDE interface on the Zaurus.  It connects to the PCMCIA
interface.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

