Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWBLFTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWBLFTo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 00:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWBLFTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 00:19:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7641 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932235AbWBLFTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 00:19:43 -0500
Date: Sun, 12 Feb 2006 00:19:29 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops in page_to_pfn in 2.6.16rc2-git9
Message-ID: <20060212051929.GB21596@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060212013328.GA11444@redhat.com> <20060211210530.797c551d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060211210530.797c551d.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2006 at 09:05:30PM -0800, Andrew Morton wrote:
 > Dave Jones <davej@redhat.com> wrote:
 > >
 > > I just hit this oops whilst trying to mount a corrupted vfat image
 > >  over loopback.
 > 
 > Repeatable?

Nope :-/

 > Are you able to put the first meg or two of that vfat image on a
 > server somewhere?

Afraid not. When I rebooted the image was 0 bytes long.

		Dave

