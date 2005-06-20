Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVFTVzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVFTVzc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVFTVxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:53:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53909 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261671AbVFTVw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:52:57 -0400
Date: Mon, 20 Jun 2005 14:53:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: mchehab@brturbo.com.br, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: 2.6.12-mm1
Message-Id: <20050620145329.2edbfde4.akpm@osdl.org>
In-Reply-To: <20050620234202.3c605b89.khali@linux-fr.org>
References: <20050619233029.45dd66b8.akpm@osdl.org>
	<20050620202947.040be273.khali@linux-fr.org>
	<20050620134146.0e5de567.akpm@osdl.org>
	<20050620231147.7232d889.khali@linux-fr.org>
	<20050620142323.2ed2180b.akpm@osdl.org>
	<20050620234202.3c605b89.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare <khali@linux-fr.org> wrote:
>
> Hi Andrew,
> 
> > One could go on at length as to why this mistake is so easy to make
> > when you're using CVS, but what it boils down to is that these
> > projects are using the wrong paradigm.  They're maintaining files,
> > whereas they should be maintaining *changes* to files.
> 
> My point exactly. You seem to excuse them for providing broken patches
> because they use the wrong tools to do the job in the first place,

No, I'm just saying...

> If CVS doesn't work, let's not use it.

Agree.

> There are other tools out there which will do the job just fine (one of
> them being quilt [1], which makes my own job so much easier since I'm
> using it, thanks to its various authors and contributors).
> 
> [1] http://savannah.nongnu.org/projects/quilt/

That works.  So does git.
