Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285338AbSA2WdZ>; Tue, 29 Jan 2002 17:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285516AbSA2Wc7>; Tue, 29 Jan 2002 17:32:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33541 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S284970AbSA2WbG>;
	Tue, 29 Jan 2002 17:31:06 -0500
Message-ID: <3C572102.37D026D7@zip.com.au>
Date: Tue, 29 Jan 2002 14:24:02 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <Pine.LNX.4.33.0201291544420.6701-100000@localhost.localdomain>,
		<Pine.LNX.4.33.0201291544420.6701-100000@localhost.localdomain> <E16VgQ0-0000AS-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> Note who the email is addressed to.  I have tried many different techniques
> for communicating with this gentleman, including self-deprecation, and they
> all seem to have the same result: no patch applied, long wait, eventually
> some other patch a long time later will obsolete my patch in some way, and
> the whole thing drifts off into forgotten history.  Err, almost forgotten,
> because the bad taste remains.
> 
> And yes, there was a successor to the patch in which I did the job 'properly'
> by cleaning up some other infrastructure instead of just fixing the bug
> locally.  There was also a long lag after I created and submitted that
> version before the bug was actually fixed, and then it was only fixed in 2.4.
> 

When all this ext2 fuss was going on, I went into ext3, changed
a few lines, fixed the bug and typed `cvs commit'.

I just thought you might enjoy hearing that.

-
