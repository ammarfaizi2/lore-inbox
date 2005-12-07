Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751746AbVLGSoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbVLGSoz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 13:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751748AbVLGSoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 13:44:55 -0500
Received: from xenotime.net ([66.160.160.81]:28385 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751745AbVLGSoy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 13:44:54 -0500
Date: Wed, 7 Dec 2005 10:44:53 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Rik van Riel <riel@redhat.com>
cc: Arjan van de Ven <arjan@infradead.org>, Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
In-Reply-To: <Pine.LNX.4.63.0512071337560.17172@cuia.boston.redhat.com>
Message-ID: <Pine.LNX.4.58.0512071041420.17648@shark.he.net>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org> 
 <20051205121851.GC2838@holomorphy.com>  <20051206011844.GO28539@opteron.random>
 <1133857767.2858.25.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.63.0512071337560.17172@cuia.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2005, Rik van Riel wrote:

> On Tue, 6 Dec 2005, Arjan van de Ven wrote:
> > On Tue, 2005-12-06 at 02:18 +0100, Andrea Arcangeli wrote:
>
> > > I am convinced that the only way to stop the erosion is to totally stop
> > > buying hardware that has only binary only drivers
>
> > this only works if more people than "just Andrea and Arjan" do it
> > though.
>
> This worked very well in the late 1990's, when various
> sites had Linux hardware compatibility lists.
>
> Does anybody still maintain a list like that today (with
> components, not just whole certified systems) ?

There are lists for USB and for IEEE1394 (Firewire).
I'm not aware of others, but then I haven't searched for others.

Such lists could tell us not only which devices work (are
supported with open source drivers) but also which devices
are not supported and hence may need attention.

There has been some discussion about OSDL attempting to do this.

-- 
~Randy
