Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264415AbUAOHXt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 02:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266194AbUAOHXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 02:23:48 -0500
Received: from gprs178-245.eurotel.cz ([160.218.178.245]:49792 "EHLO
	midnight.ucw.cz") by vger.kernel.org with ESMTP id S264415AbUAOHXs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 02:23:48 -0500
Date: Thu, 15 Jan 2004 08:24:11 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Murilo Pontes <murilo_pontes@yahoo.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] ABNT2 keyboards not work with >= 2.6.1 with or without -mm patchs
Message-ID: <20040115072411.GA526@ucw.cz>
References: <200401142326.21543.murilo_pontes@yahoo.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401142326.21543.murilo_pontes@yahoo.com.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 11:26:21PM +0000, Murilo Pontes wrote:

> BUG: ABNT2 keyboards not work with >= 2.6.1 with or without -mm patchs
> DESCRIPTION: The "/ ?" not work on console-framebuffer

Known problem. They should work with recent -mm (if Andrew applied my
patch), and that patch should go to 2.6.2 soon. Please test if it works
correctly with latest -mm kernel. 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
