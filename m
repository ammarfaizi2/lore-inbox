Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310130AbSCFTOg>; Wed, 6 Mar 2002 14:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310137AbSCFTO1>; Wed, 6 Mar 2002 14:14:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13061 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310130AbSCFTON>;
	Wed, 6 Mar 2002 14:14:13 -0500
Message-ID: <3C866A1C.FB0253FE@zip.com.au>
Date: Wed, 06 Mar 2002 11:12:28 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Bulent Abali <abali@us.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct page shrinkage
In-Reply-To: <OFC19C560E.A00F9111-ON85256B74.006633D4@pok.ibm.com>,
		<OFC19C560E.A00F9111-ON85256B74.006633D4@pok.ibm.com> <20020306185004.GA32692@matchmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> 
> On Wed, Mar 06, 2002 at 01:41:51PM -0500, Bulent Abali wrote:
> > What is the outlook for inclusion of this patch in the main kernel?  Do you
> > plan to submit or have been included yet?
> 
> I believe it is planned to be submitted to 2.5.

hmm.

> Andrew, why isn't this listed on the 2.5 status page?

Coz it's something I pulled out of my butt just a couple of
weeks back :)

We'll see how it pans out.  I must say that after two years
of fixing other guys' bugs, it's fun writing some of my own.

-
