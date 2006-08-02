Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWHBU1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWHBU1K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 16:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWHBU1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 16:27:10 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:26534 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932152AbWHBU1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 16:27:09 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Linux v2.6.18-rc3
Date: Wed, 2 Aug 2006 22:26:19 +0200
User-Agent: KMail/1.9.3
Cc: Jesse Brandeburg <jesse.brandeburg@gmail.com>,
       Andrew Morton <akpm@osdl.org>, stern@rowland.harvard.edu,
       linux-kernel@vger.kernel.org, torvalds@osdl.org,
       cpufreq@www.linux.org.uk
References: <20060731081112.05427677.akpm@osdl.org> <200608022216.54797.rjw@sisk.pl> <20060802202309.GD7173@flint.arm.linux.org.uk>
In-Reply-To: <20060802202309.GD7173@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608022226.19993.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 August 2006 22:23, Russell King wrote:
> On Wed, Aug 02, 2006 at 10:16:54PM +0200, Rafael J. Wysocki wrote:
> > Please try the following patch from Russell King and see if it helps.
> 
> I'd have missed this if it weren't for that comment.  It hasn't been
> merged so far due to the lack of feedback on it...  Thanks for trying
> to get that feedback.

Well, it fixes the problem for me. ;-)
