Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263407AbUEGInR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbUEGInR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 04:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbUEGImc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 04:42:32 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:56332 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263370AbUEGIe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 04:34:56 -0400
Date: Fri, 7 May 2004 09:34:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Oliver Pitzeier <oliver@linux-kernel.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange Linux behaviour!?
Message-ID: <20040507093455.A27829@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Oliver Pitzeier <oliver@linux-kernel.at>,
	linux-kernel@vger.kernel.org
References: <409B4494.5253316B@melbourne.sgi.com> <013001c4340d$e9860470$d50110ac@sbp.uptime.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <013001c4340d$e9860470$d50110ac@sbp.uptime.at>; from oliver@linux-kernel.at on Fri, May 07, 2004 at 10:33:02AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2004 at 10:33:02AM +0200, Oliver Pitzeier wrote:
> cd /usr
> mkdir test
> mkdir: cannot create directory `test': No space left on device

?Have you checked whether you're out of inodes?

