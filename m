Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVFQWuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVFQWuz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 18:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVFQWuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 18:50:55 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:22466 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261834AbVFQWuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 18:50:07 -0400
Date: Fri, 17 Jun 2005 15:49:54 -0700
From: Greg KH <gregkh@suse.de>
To: Daniele Gaffuri <d.gaffuri@reply.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Hidden SMBus bridge on Toshiba Tecra M2
Message-ID: <20050617224953.GA23742@suse.de>
References: <TO1FRES03HbOEMBRWtC0000452f@to1fres03.replynet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TO1FRES03HbOEMBRWtC0000452f@to1fres03.replynet.prv>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2005 at 12:36:18AM +0200, Daniele Gaffuri wrote:
> Here's a trivial patch, against 2.6.12-rc6, to unhide SMBus on Toshiba
> Centrino laptops using Intel 82855PM chipset.

Your patch is linewrapped, and missing a Signed-off-by: line.  Care to
redo it?

thanks,

greg k-h
