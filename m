Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbUB0QXh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 11:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263034AbUB0QXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 11:23:37 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:6326 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263033AbUB0QXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 11:23:36 -0500
Date: Fri, 27 Feb 2004 16:21:52 +0000
From: Dave Jones <davej@redhat.com>
To: Brad Davidson <kiloman@oatmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: drivers/ieee1394/sbp2.c:734: error: `host' undeclared (first use in this function) 2.6.3-bk3
Message-ID: <20040227162152.GB15016@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Brad Davidson <kiloman@oatmail.org>, linux-kernel@vger.kernel.org
References: <403F5D3A.4080101@oatmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403F5D3A.4080101@oatmail.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 07:07:38AM -0800, Brad Davidson wrote:
 > All,
 > 
 > This is the same change I made in my local tree against 2.6.3-bk4. It 
 > was pretty much a blind change, so I have no idea if it's the right 
 > thing to do or not, but it certainly compiles now. I've connected a few 
 > firewire devices and they appear to work as expected without anything 
 > going belly-up, so it's good enought for me. I guess only Bob really 
 > knows if that's what he meant.

This got fixed in -bk5 iirc.

		Dave


