Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316633AbSEQSEw>; Fri, 17 May 2002 14:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316634AbSEQSEv>; Fri, 17 May 2002 14:04:51 -0400
Received: from dsl-213-023-043-065.arcor-ip.net ([213.23.43.65]:61315 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316633AbSEQSEu>;
	Fri, 17 May 2002 14:04:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        Peter Chubb <peter@chubb.wattle.id.au>
Subject: Re: [PATCH] remove 2TB block device limit
Date: Fri, 17 May 2002 20:02:56 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Anton Altaparmakov <aia21@cantab.net>,
        Peter Chubb <peter@chubb.wattle.id.au>,
        Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
        axboe@suse.de, akpm@zip.com.au, martin@dalecki.de,
        neilb@cse.unsw.edu.au
In-Reply-To: <200205171332.IAA93516@tomcat.admin.navo.hpc.mil>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E178m48-00006Z-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 May 2002 15:32, Jesse Pollard wrote:
> And for the curious, the filesystems are SAMFS and SAMQFS on Sun E10000s.
> We migrated the data from Cray NC1 filesystems with DMF - Cray data
> migration facility (this took over 4 months. Would have taken only a month
> or two, but we also had to accept new data at the same time).

Thanks for the fascinating data, however you left out one crucial piece of
information: how many data bits in your processor?

-- 
Daniel
