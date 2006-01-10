Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWAJSud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWAJSud (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 13:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWAJSud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 13:50:33 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:49592 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751170AbWAJSuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 13:50:32 -0500
Date: Tue, 10 Jan 2006 13:50:30 -0500
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Bernd Eckenfels <be-news06@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2G memory split
Message-ID: <20060110185030.GB26581@csclub.uwaterloo.ca>
References: <E1EwNc8-00063F-00@calista.inka.de> <43C3E142.1080206@wolfmountaingroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C3E142.1080206@wolfmountaingroup.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 09:30:58AM -0700, Jeff V. Merkey wrote:
> Bernd Eckenfels wrote:
> 
> Here are the patches I use for the splitting.  They work well.    The 
> methods employed in Red Hat ES are far better and I am surprised
> no one has simply integrated those patches into the kernel which are 4GB 
> / 4GB  kernel/user. 

I was under the impression the 4G/4G split had some non negligable
performance penalties compared to the other options.

Len Sorensen
