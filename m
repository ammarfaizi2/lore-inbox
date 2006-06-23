Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932990AbWFWKLC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932990AbWFWKLC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932992AbWFWKLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:11:02 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:48331 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932991AbWFWKLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:11:00 -0400
Date: Fri, 23 Jun 2006 12:10:35 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Jeff Dike <jdike@addtoit.com>
cc: Andrew Morton <akpm@osdl.org>, Theodore Tso <tytso@mit.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1: UML failing w/o SKAS enabled
In-Reply-To: <20060623025418.GC8316@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.64.0606231209000.17704@scrub.home>
References: <20060621034857.35cfe36f.akpm@osdl.org> <20060622213443.GA22303@thunk.org>
 <20060622145743.2accfeaf.akpm@osdl.org> <20060623025418.GC8316@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 22 Jun 2006, Jeff Dike wrote:

> The important thing is to start with a defconfig in order to avoid
> config grabbing the host's config from /boot.

BTW this can be now configured. Check DEFCONFIG_LIST in init/Kconfig in 
-mm.

bye, Roman
