Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264534AbUAARst (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 12:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbUAARst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 12:48:49 -0500
Received: from havoc.gtf.org ([63.247.75.124]:7869 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264534AbUAARss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 12:48:48 -0500
Date: Thu, 1 Jan 2004 12:48:45 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Paul Jackson <pj@sgi.com>
Cc: Karel Kulhav? <clock@twibright.com>, linux-kernel@vger.kernel.org
Subject: Re: Compatibility of Nvidia NVNET driver license with GPL
Message-ID: <20040101174845.GB2022@gtf.org>
References: <20031231073101.A474@beton.cybernet.src> <20031231211101.68ba1362.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031231211101.68ba1362.pj@sgi.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 09:11:01PM -0800, Paul Jackson wrote:
> nVidia's _video_ drivers are mostly proprietary code that is not
> specific to Linux.  They provide a GPL wrapper or shim that, apparently
> in the view of their lawyers, insulates their proprietary code from GPL
> license terms.
> 
> Perhaps their network software is done the same way?

It's a fair argument that nVidia has significant IP in their video
drivers...  I understand that's where they get a fair amount of their
speed.

For a network driver, nVidia will have a really tough time convincing me
there is useful IP in their NIC driver, or the NIC itself :)  There are
much more advanced NICs out there (with public docs, no less)...

	Jeff



