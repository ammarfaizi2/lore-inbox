Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbVLEMTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbVLEMTf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 07:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbVLEMTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 07:19:35 -0500
Received: from holomorphy.com ([66.93.40.71]:17635 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S932385AbVLEMTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 07:19:34 -0500
Date: Mon, 5 Dec 2005 04:18:51 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
Message-ID: <20051205121851.GC2838@holomorphy.com>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133779953.9356.9.camel@laptopd505.fenrus.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 11:52:32AM +0100, Arjan van de Ven wrote:
> Now this scenario may sound unlikely to you. And thankfully the main
> assumption (the December 6th event) is extremely unlikely.  
> However, and this unfortunately, several of the other "leaps" aren't
> that unlikely. In fact, some of these results are likely to happen
> regardless; witness the flamewars on lkml about breaking module API/ABI.
> Witness the ndiswrapper effect of vendors now saying "we support linux
> because ndiswrapper can use our windows driver". I hope they won't
> happen. Some of that hope will be idle hope, but I believe that the
> advantages of freedom in the end are strong enough to overcome the
> counter forces. 

The December 6 event is extraordinarily unlikely. What's vastly more
likely is consistent "erosion" over time. First the 3D video drivers,
then the wireless network drivers, then the fakeraid drivers, and so on.
Each instance degrades Linux' capabilities without such drivers, and
incrementally reduces the userbase of newer releases. I doubt there will
be a "revolutionary" step at all, just progressively more erosion over
time. As things go, Linux gets "flakier" as binary modules break for
people when they upgrade, new versions support less hardware as the
binary modules hobble them, and so on. DRM even threatens to prevent
some machines from booting Linux in the categorical sense.

I expect the closed source IP affairs rather to keep chipping away
until Linux is dead, or they get tired and change strategies to kill it,
versus any sudden changes of course.


-- wli
