Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030311AbWBVBDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbWBVBDu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 20:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWBVBDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 20:03:50 -0500
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:58799 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751231AbWBVBDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 20:03:49 -0500
Date: Tue, 21 Feb 2006 17:03:47 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Christoph Hellwig <hch@infradead.org>, Oleg Drokin <green@linuxhacker.ru>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: FMODE_EXEC or alike?
Message-ID: <20060222010347.GA27318@taniwha.stupidest.org>
References: <20060220221948.GC5733@linuxhacker.ru> <20060221103949.GD19349@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221103949.GD19349@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 10:39:49AM +0000, Christoph Hellwig wrote:

> The patch looks fine to me.  We can put it in once we'll put in the
> full lustre client.

ocfs2 could probably use it sooner or later surely?
