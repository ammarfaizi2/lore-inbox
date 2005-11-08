Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbVKHNlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVKHNlX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 08:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbVKHNlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 08:41:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37090 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932246AbVKHNlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 08:41:22 -0500
Date: Tue, 8 Nov 2005 13:41:21 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] provide stricmp
Message-ID: <20051108134121.GA15406@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org
References: <4370AF1E.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4370AF1E.76F0.0078.0@novell.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 01:58:54PM +0100, Jan Beulich wrote:
> While strnicmp existed in the set of string support routines, stricmp
> didn't, which this patch adjusts.

There's still no user.  Please stop blindly resubmitting things that
have been rejected.

