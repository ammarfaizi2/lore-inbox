Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbUASPA6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 10:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265149AbUASPA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 10:00:57 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:48536 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265053AbUASPA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 10:00:56 -0500
Date: Mon, 19 Jan 2004 14:59:55 +0000
From: Dave Jones <davej@redhat.com>
To: Ryan Reich <ryanr@uchicago.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Overlapping MTRRs in 2.6.1
Message-ID: <20040119145955.GA22265@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ryan Reich <ryanr@uchicago.edu>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0401181458080.2194@ryanr.aptchi.homelinux.org> <20040119095003.GB8621@redhat.com> <Pine.LNX.4.58.0401190818450.1003@ryanr.aptchi.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401190818450.1003@ryanr.aptchi.homelinux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 08:19:49AM -0600, Ryan Reich wrote:

 > > Make sure you're loading both the agpgart module, *AND* the
 > > relevant chipset driver for your board, ie via-agp, intel-agp or the like.
 > 
 > Thanks, that's what I was doing.  I didn't notice that the system had changed
 > from 2.4.

It's mentioned in the http://www.codemonkey.org.uk/docs/post-halloween-2.6.txt
document I wrote, which is 'must read' material if you're coming from 2.4 with
no idea of what changed from a user point of view.

		Dave

