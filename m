Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVCQVT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVCQVT2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 16:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVCQVT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 16:19:28 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:38289 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261159AbVCQVT0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 16:19:26 -0500
Date: Thu, 17 Mar 2005 22:20:23 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] Fix kconfig docs typo: integer -> int
Message-ID: <20050317212023.GA13119@mars.ravnborg.org>
References: <20050310153900.B75A56475@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310153900.B75A56475@zion>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 04:38:58PM +0100, blaisorblade@yahoo.it wrote:
> 
> Trivial correction: the type of numbers for Kconfig is not integer but int (I
> just verified because I followed the wrong docs and got a error, I looked
> elsewhere and they are using int, and int works for me). Please apply.

Applied - thanks.

	Sam
