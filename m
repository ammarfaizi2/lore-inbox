Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTLAEvH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 23:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbTLAEvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 23:51:07 -0500
Received: from holomorphy.com ([199.26.172.102]:30152 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263298AbTLAEvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 23:51:05 -0500
Date: Sun, 30 Nov 2003 20:51:01 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: James W McMechan <mcmechanjw@juno.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops with tmpfs on both 2.4.22 & 2.6.0-test11
Message-ID: <20031201045101.GP8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	James W McMechan <mcmechanjw@juno.com>,
	linux-kernel@vger.kernel.org
References: <20031130.180800.-1591395.6.mcmechanjw@juno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031130.180800.-1591395.6.mcmechanjw@juno.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 06:06:41PM -0800, James W McMechan wrote:
> Have you got a suggestion on who to bug, I have not found
> maintainers on tmpfs or now the libfs section.

Hugh Dickins is highly clueful and generally maintains tmpfs. He's
fixed bugs in fs/libfs.c before, too.


-- wli
