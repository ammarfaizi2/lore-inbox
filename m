Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264609AbUFPTUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264609AbUFPTUq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 15:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264648AbUFPTUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 15:20:45 -0400
Received: from havoc.gtf.org ([216.162.42.101]:60621 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264609AbUFPTUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 15:20:45 -0400
Date: Wed, 16 Jun 2004 15:20:43 -0400
From: David Eger <eger@havoc.gtf.org>
To: Kevin Zhou <kvzrock@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: correced URL for bug.avi
Message-ID: <20040616192043.GA13421@havoc.gtf.org>
References: <40CBBF38.5080905@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40CBBF38.5080905@cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could you give me the output of fbset -a ?

>From your screen shot, my best guess is some disconnect between what the
driver thinks the framebuffer format is, and what the hardware interprets
it as...

Is this the screen at boot?  (you haven't switched from X or anything?)
Are the pixels actually flickering or is that an artifact of the video?

-dte
