Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264836AbSKNKm3>; Thu, 14 Nov 2002 05:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264838AbSKNKm3>; Thu, 14 Nov 2002 05:42:29 -0500
Received: from hazard.jcu.cz ([160.217.1.6]:31369 "EHLO hazard.jcu.cz")
	by vger.kernel.org with ESMTP id <S264836AbSKNKm3>;
	Thu, 14 Nov 2002 05:42:29 -0500
Date: Thu, 14 Nov 2002 11:49:19 +0100
From: Jan Marek <linux@hazard.jcu.cz>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.4[5-7]]: console w/o iso-latin-2 chars?
Message-ID: <20021114104919.GB1421@hazard.jcu.cz>
References: <20021112074156.GA8292@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021112074156.GA8292@hazard.jcu.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo l-k,

On Tue, Nov 12, 2002 at 08:41:56AM +0100, Jan Marek wrote:
> Hallo l-k,
> 
> I have two computers, where I'm testing new kernels. On both computers I
> have latest Debian sid. I'm don't using framebuffer (as you can see from
> attached .config files). config-notebook is for kernel 2.5.44 and
> config-desktop is for kernel 2.5.47.
> 
> Please contact me, if you will want some additional informations...

I have some additional info's:

I must do 'consolechars -f iso02.f16 --sfm=iso02' multiple times (at
least three times) to get correct behavior in 2.4.47??? But after that
it works OK...

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080
