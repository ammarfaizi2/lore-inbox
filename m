Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbTJGGvU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 02:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbTJGGvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 02:51:19 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:59406 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261744AbTJGGvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 02:51:19 -0400
Date: Tue, 7 Oct 2003 10:51:16 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test6[-mm4] boot failure on alpha
Message-ID: <20031007105116.A616@den.park.msu.ru>
References: <20031006235759.GA26127@wang-fu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031006235759.GA26127@wang-fu.org>; from kraken@drunkmonkey.org on Mon, Oct 06, 2003 at 06:57:59PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 06:57:59PM -0500, Nathan wrote:
> I'm having a problem getting 2.6.0-test6 and/or 2.6.0-test6-mm4 to boot
> on my AS2100.  It boots and runs fine with 2.4.21.  The following is what
> I get when I boot -test6-mm4 (although it stops at the same point with
> vanilla -test6).  Any suggestions, comments, or requests for further
> information are welcome.

Can you reproduce that with "nosmp" on boot command line?

Ivan.
