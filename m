Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268276AbUHXUfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268276AbUHXUfh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 16:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268286AbUHXUfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 16:35:36 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:62113 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268285AbUHXUfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 16:35:19 -0400
Subject: Re: silent semantic changes with reiser4
From: Lee Revell <rlrevell@joe-job.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@osdl.org>, reiser@namesys.com,
       linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040824202521.GA26705@lst.de>
References: <20040824202521.GA26705@lst.de>
Content-Type: text/plain
Message-Id: <1093379718.817.63.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 24 Aug 2004 16:35:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-24 at 16:25, Christoph Hellwig wrote:
>    - O_DIRECTORY opens succeed on all files on reiser4.  Besides breaking
>      .htaccess handling in apache and glibc compilation this also renders
>      this flag entirely useless and opens up the races it tries to
>      prevent against cmpletely useless

So `find -type d' would list every file on the system?

Lee

