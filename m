Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbTJWFv7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 01:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbTJWFv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 01:51:59 -0400
Received: from anchor-post-37.mail.demon.net ([194.217.242.87]:18963 "EHLO
	anchor-post-37.mail.demon.net") by vger.kernel.org with ESMTP
	id S261667AbTJWFv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 01:51:58 -0400
From: Matt Gibson <gothick@gothick.org.uk>
Organization: The Wardrobe Happy Cow Emporium
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test8: 'sleeping function called from invalid context at include/asm/semaphore.h: 119' at boot
Date: Wed, 22 Oct 2003 23:02:35 +0100
User-Agent: KMail/1.5.4
References: <rcug61-a26.ln1@bd-home-comp.no-ip.org>
In-Reply-To: <rcug61-a26.ln1@bd-home-comp.no-ip.org>
Cc: bd <bdonlan@users.sourceforge.net>
X-Pointless-MIME-Header: yes
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310222302.35627.gothick@gothick.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 Oct 2003 01:08, bd wrote:
> When I boot 2.6.0-test8, it sends the following to dmesg:
> Debug: sleeping function called from invalid context at
> include/asm/semaphore.h:

See http://marc.theaimsgroup.com/?l=linux-kernel&m=106652263305078&w=2

M

-- 
"It's the small gaps between the rain that count,
 and learning how to live amongst them."
	      -- Jeff Noon
