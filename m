Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVBOWoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVBOWoL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 17:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVBOWny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 17:43:54 -0500
Received: from colin2.muc.de ([193.149.48.15]:26632 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261925AbVBOWma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 17:42:30 -0500
Date: 15 Feb 2005 23:42:26 +0100
Date: Tue, 15 Feb 2005 23:42:26 +0100
From: Andi Kleen <ak@muc.de>
To: YhLu <YhLu@tyan.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: X86_64 kernel support MAX memory.
Message-ID: <20050215224226.GA87835@muc.de>
References: <3174569B9743D511922F00A0C943142308085866@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C943142308085866@TYANWEB>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 02:34:17PM -0800, YhLu wrote:
> If only use 64G RAM, it works well.

Are you sure the RAM is not broken?  The more you have of it
the more likely one DIMM is bad.

Otherwise debug it. What's the oops dump?

-Andi
