Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTEUMWL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 08:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbTEUMWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 08:22:11 -0400
Received: from sklave3.rackland.de ([213.133.101.23]:30667 "EHLO
	sklave3.rackland.de") by vger.kernel.org with ESMTP id S261827AbTEUMWL
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 21 May 2003 08:22:11 -0400
From: Hadmut Danisch <hadmut@danisch.de>
Date: Wed, 21 May 2003 14:30:01 +0200
To: Dave Jones <davej@codemonkey.org.uk>, Linux-Kernel@vger.kernel.org
Subject: Re: speechless 2.5.69 kernel?
Message-ID: <20030521123001.GA7884@danisch.de>
References: <20030521103713.GA5863@danisch.de> <20030521112115.GA3991@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030521112115.GA3991@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 12:21:15PM +0100, Dave Jones wrote:
> First make sure your .config contains
> CONFIG_INPUT=y, CONFIG_VT=y and CONFIG_VT_CONSOLE=y
> 
> if they do already, then.. if you have CONFIG_VIDEO_SELECT=y
> try turning that off.

Thanks for the hint, but it didn't help. :-(

regards
Hadmut

