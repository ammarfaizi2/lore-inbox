Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263444AbVCMIRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263444AbVCMIRN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 03:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263445AbVCMIRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 03:17:13 -0500
Received: from ns.suse.de ([195.135.220.2]:39317 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263444AbVCMIRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 03:17:11 -0500
Date: Sun, 13 Mar 2005 09:17:09 +0100
From: Olaf Hering <olh@suse.de>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] be more verbose in gen-devlist
Message-ID: <20050313081709.GA26100@suse.de>
References: <20050311192858.GA11077@suse.de> <20050312203642.GC11865@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050312203642.GC11865@kroah.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Mar 12, Greg KH wrote:

> Why #if this?  Why not just always do this?

Because it always triggers with current sf.net snapshot.
