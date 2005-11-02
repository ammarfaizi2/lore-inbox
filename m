Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932700AbVKBJrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700AbVKBJrs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 04:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbVKBJrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 04:47:47 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:48866 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932700AbVKBJrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 04:47:46 -0500
Date: Wed, 2 Nov 2005 10:47:18 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Josh Boyer <jdub@us.ibm.com>
Cc: Adrian Bunk <bunk@stusta.de>, dwmw2@infradead.org, jffs-dev@axis.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] remove fs/jffs2/ioctl.c
Message-ID: <20051102094718.GA18857@wohnheim.fh-wedel.de>
References: <20051101205119.GY8009@stusta.de> <1130879436.3775.1.camel@windu.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1130879436.3775.1.camel@windu.rchland.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 November 2005 15:10:36 -0600, Josh Boyer wrote:
> On Tue, 2005-11-01 at 21:51 +0100, Adrian Bunk wrote:
> > Is there any reason for keeping fs/jffs2/ioctl.c?
> 
> I can think of some various things that could be done with it, but that
> would require time and effort.  Unless David or Thomas have an
> objections, I think it can go.

And for the last couple of years, no problem seemed urgent enough for
someone to actually implement something.  I vote for removal.

Jörn

-- 
This above all: to thine own self be true.
-- Shakespeare
