Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbTIUOsE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 10:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbTIUOsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 10:48:04 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:22630 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262416AbTIUOsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 10:48:02 -0400
Date: Sun, 21 Sep 2003 15:47:27 +0100
From: Dave Jones <davej@redhat.com>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix Athlon MCA
Message-ID: <20030921144727.GP10474@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Kronos <kronos@kronoz.cjb.net>, linux-kernel@vger.kernel.org
References: <20030921143934.GA1867@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030921143934.GA1867@dreamland.darkstar.lan>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 21, 2003 at 04:39:34PM +0200, Kronos wrote:

 > We really want to clean all MC*_STATUS. I'm currently running linux 2.6.0-t5
 > + this patch and I don't see the MCE messages on boot anymore. 

Patch looks good to me.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
