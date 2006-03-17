Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752473AbWCQBvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbWCQBvc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 20:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752484AbWCQBvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 20:51:32 -0500
Received: from uproxy.gmail.com ([66.249.92.203]:20573 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752473AbWCQBvb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 20:51:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HLW8M/HvNpO5Pd1S91ZnGMRNcVE8tTlfP77fc8myyzDJdvnq4LqZcp/yg6GbHU270+/ThC/3pTCLnzOipZ8xXAePQA3kyX7dy8JYQEmtN9178pIQ06Lc2NEIgfwlFpelPgrn9Pvf1eQ14teY2O+wpa4UMBwtxvuDyRLpGcgINho=
Message-ID: <93564eb70603161751g734b0690t@mail.gmail.com>
Date: Fri, 17 Mar 2006 10:51:29 +0900
From: "Samuel Masham" <samuel.masham@gmail.com>
To: "Phillip Lougher" <phillip@lougher.org.uk>
Subject: Re: [ANN] Squashfs 3.0 released
Cc: "Andreas Dilger" <adilger@clusterfs.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <CF2CC9AC-3695-45C1-9FA6-9BDAAA6418DD@lougher.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <B6C8687D-6543-42A1-9262-653C4D3C30B2@lougher.org.uk>
	 <20060317010529.GB30801@schatzie.adilger.int>
	 <CF2CC9AC-3695-45C1-9FA6-9BDAAA6418DD@lougher.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillip,

On 17/03/06, Phillip Lougher <phillip@lougher.org.uk> wrote:
> and in constrained
> block device/memory systems (e.g. embedded systems) where low
> overhead is
> needed."
>
> At the moment it tends to be used for embedded systems, and liveCDs.

>From the embedded side here...

Have you any idea how the performance of version 3.0 stack up against 2.1?

You haven't updated the readme.performance file yet :)

thanks

Samuel

ps Looking forward to seeing squashfs in main line soon :)
