Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbTI1QkX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 12:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbTI1QkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 12:40:23 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:10548 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262596AbTI1QkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 12:40:22 -0400
Date: Sun, 28 Sep 2003 17:40:02 +0100
From: Dave Jones <davej@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [bk patches] 2.6.x misc updates
Message-ID: <20030928164002.GA4931@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20030928144428.GA16477@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030928144428.GA16477@gtf.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 28, 2003 at 10:44:28AM -0400, Jeff Garzik wrote:
 > 
 > Linus, please do a
 > 
 > 	bk pull bk://kernel.bkbits.net/jgarzik/misc-2.5
 > 
 > This will update the following files:
 > 
 >    * char/agp/amd64-agp: properly suffix 64-bit constants

Please don't touch this. It needs fixing in a different way
for 32bit.

I'll dig out the specs and fix it up properly later.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
