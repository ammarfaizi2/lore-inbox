Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161457AbWASWao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161457AbWASWao (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161459AbWASWao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:30:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46820 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161457AbWASWan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:30:43 -0500
Date: Thu, 19 Jan 2006 17:30:42 -0500
From: Alan Cox <alan@redhat.com>
To: Dave Jones <davej@redhat.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>, alan@redhat.com
Subject: Re: EDAC config cleanup
Message-ID: <20060119223042.GB7652@devserv.devel.redhat.com>
References: <20060119221006.GA31404@redhat.com> <Pine.LNX.4.58.0601191411560.11660@shark.he.net> <20060119222350.GU21663@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119222350.GU21663@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 05:23:50PM -0500, Dave Jones wrote:
> The AMD76x chipsets aren't used in 64-bit, so don't
> offer the driver to the user.
> 
> Signed-off-by: Dave Jones <davej@redhat.com>

Acked-by: Alan Cox <alan@redhat.com>
