Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbVCQSUC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbVCQSUC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 13:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbVCQSUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 13:20:02 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:1402 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261987AbVCQST7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 13:19:59 -0500
Date: Thu, 17 Mar 2005 19:20:48 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jens Langner <Jens.Langner@light-speed.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11.4 1/1] fs: new filesystem implementation VXEXT1.0
Message-ID: <20050317182048.GA16328@mars.ravnborg.org>
References: <42399F54.1010108@light-speed.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42399F54.1010108@light-speed.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2005 at 04:16:36PM +0100, Jens Langner wrote:
> Hi,
> 
> The following URL is link to a large patch for a possible integration of 
> a new filesystem implementation in the misc section of the kernel tree. 

If you like people to review it te best thing to do is to break it up
in smaller logical selfcontained pieces (not just file-by-file) and post
these. People on this mailing list seldom follow URL's.

	Sam
