Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263879AbUECUGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263879AbUECUGv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 16:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263881AbUECUGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 16:06:51 -0400
Received: from box.punkt.pl ([217.8.180.66]:24334 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S263879AbUECUG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 16:06:27 -0400
From: Mariusz Mazur <mmazur@kernel.pl>
To: Christoph Hellwig <hch@infradead.org>,
       "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.5.1
Date: Mon, 3 May 2004 22:05:46 +0200
User-Agent: KMail/1.6.1
References: <200405030111.49802.mmazur@kernel.pl> <40969C87.4060804@backtobasicsmgmt.com> <20040503203156.A14171@infradead.org>
In-Reply-To: <20040503203156.A14171@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200405032205.46882.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On pon 3. maja 2004 21:31, Christoph Hellwig wrote:
> On Mon, May 03, 2004 at 12:24:55PM -0700, Kevin P. Fleming wrote:
> > Mariusz' headers work really well; there are people building complete
> > systems (X/KDE/GNOME/etc.) using them without any difficulties at this
> > point.
>
> The thing is they're still conceptually wrong.  Glibc should provide
> working and full-featured networking headers.

Or should have a mechanism for linux headers to provide them in a clean way 
(which is probably a better option since glibc will always lack behind linux' 
functionality). Either way it's not in my power to introduce the proper fix. 
Care to do The Right Thing (tm)? :)


-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again
