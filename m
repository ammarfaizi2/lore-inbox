Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVANXaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVANXaj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 18:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbVANXai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 18:30:38 -0500
Received: from dhcp93115068.columbus.rr.com ([24.93.115.68]:47634 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S261791AbVANXaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 18:30:25 -0500
Date: Fri, 14 Jan 2005 18:30:20 -0500
From: Joseph Fannin <jhf@rivenstone.net>
To: Daniel Kirsten <Daniel.Kirsten@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm1  waiting-10s-before-mounting-root-....
Message-ID: <20050114233020.GA2181@samarkand.rivenstone.net>
Mail-Followup-To: Daniel Kirsten <Daniel.Kirsten@gmx.net>,
	linux-kernel@vger.kernel.org
References: <572.1105705748@www33.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <572.1105705748@www33.gmx.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 01:29:08PM +0100, Daniel Kirsten wrote:
> Hallo,
> 
> I have to unpatch waiting-10s-before-mounting-root-filesystem.patch, 
> otherwise I cannot mount the root file system when booting. 
> 

    Are you using an initrd?

(Just another user trying to work out what's going on.) 
-- 
Joseph Fannin
jhf@rivenstone.net
