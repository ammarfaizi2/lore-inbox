Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbTDXV3E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 17:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264528AbTDXV3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 17:29:01 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:23944 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264527AbTDXV27
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 17:28:59 -0400
Date: Thu, 24 Apr 2003 22:41:00 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Daniel Phillips <phillips@arcor.de>
Cc: Trammell Hudson <hudson@osresearch.net>, linux-kernel@vger.kernel.org
Subject: Re: gettimeofday running backwards on 2.4.20
Message-ID: <20030424214100.GL30082@mail.jlokier.co.uk>
References: <20030422232316.GF20108@osbox.osresearch.net> <20030424193410.C52BF12F067@mx12.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424193410.C52BF12F067@mx12.arcor-online.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> Applications like games (but not only games) can get pretty messed up by a 
> timeofday that jumps backwards every couple of seconds.

It's a foolish game that doesn't implement your monotonicity algorithm
itself...

-- Jamie
