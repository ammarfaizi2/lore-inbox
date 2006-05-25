Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030371AbWEYTnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbWEYTnW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 15:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbWEYTnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 15:43:22 -0400
Received: from smtp-vbr17.xs4all.nl ([194.109.24.37]:8452 "EHLO
	smtp-vbr17.xs4all.nl") by vger.kernel.org with ESMTP
	id S1030371AbWEYTnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 15:43:21 -0400
Date: Thu, 25 May 2006 21:43:15 +0200
From: bjdouma <bjdouma@xs4all.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add compile domain (was: Re: [PATCH] Well, Linus seems to like Lordi...)
Message-ID: <20060525194315.GA14114@skyscraper.unix9.prv>
References: <20060525141714.GA31604@skunkworks.cabal.ca> <Pine.LNX.4.61.0605251829410.6951@yvahk01.tjqt.qr> <Pine.LNX.4.64.0605250943520.5623@g5.osdl.org> <Pine.LNX.4.61.0605252027380.13379@yvahk01.tjqt.qr> <Pine.LNX.4.64.0605251146260.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605251146260.5623@g5.osdl.org>
X-Disclaimer: sorry
X-Operating-System: human brain v1.04E11
Organization: A training zoo
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 11:47:39AM -0700, Linus Torvalds wrote:

> On Thu, 25 May 2006, Jan Engelhardt wrote:
> >
> > # hostname --fqdn
> > shanghai.hopto.org
> 
> Ahh. I wonder how portable this is. We could certainly make the kernel 
> build use "hostname --fqdn" if that works across all versions.
> 
> That code hasn't changed in a looong time, and I suspect that "--fqdn" 
> didn't exist back when.. 

It still doesn't if you're using GNU coreutils' hostname...

Bauke Jan Douma
