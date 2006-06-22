Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932729AbWFVXCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729AbWFVXCZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 19:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbWFVXCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 19:02:24 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:58892 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932713AbWFVXCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 19:02:22 -0400
Date: Fri, 23 Jun 2006 01:02:19 +0200
From: Olivier Galibert <galibert@pobox.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is the x86-64 kernel size limit real?
Message-ID: <20060622230219.GA61221@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20060622204627.GA47994@dspnet.fr.eu.org> <e7f2jq$r17$1@terminus.zytor.com> <20060622220057.GB52945@dspnet.fr.eu.org> <449B1D95.4090705@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449B1D95.4090705@zytor.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 03:45:41PM -0700, H. Peter Anvin wrote:
> The limit should be removed from the boot tools; since we're talking 
> uncompressed limits those should be tested in the linker script if anywhere.

Probably yeah.  And the two build.c files should become one too.
There is version drift already.  I'm not a x86-64 maintainer though :-)

  OG.

