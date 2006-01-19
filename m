Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422679AbWASWaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422679AbWASWaK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161459AbWASWaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:30:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31716 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161457AbWASWaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:30:08 -0500
Date: Thu, 19 Jan 2006 17:30:06 -0500
From: Alan Cox <alan@redhat.com>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       alan@redhat.comy
Subject: Re: EDAC config cleanup
Message-ID: <20060119223006.GA7652@devserv.devel.redhat.com>
References: <20060119221006.GA31404@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119221006.GA31404@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 05:10:06PM -0500, Dave Jones wrote:
> -	depends on EDAC_MM_EDAC  && PCI
> +	depends on EDAC_MM_EDAC && PCI X86_32

NAK  add another &&
