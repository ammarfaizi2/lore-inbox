Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132128AbRCVSWH>; Thu, 22 Mar 2001 13:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132137AbRCVSV7>; Thu, 22 Mar 2001 13:21:59 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:65042 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S132128AbRCVSVp>;
	Thu, 22 Mar 2001 13:21:45 -0500
Date: Thu, 22 Mar 2001 11:21:54 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: nbecker@fred.net, linux-kernel@vger.kernel.org
Subject: Re: regression testing
Message-ID: <20010322112154.D17926@hq.fsmlabs.com>
In-Reply-To: <x88zoeeeyh8.fsf@adglinux1.hns.com> <Pine.LNX.4.21.0103221334570.21415-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0103221334570.21415-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Thu, Mar 22, 2001 at 01:37:13PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a start for PPC.  It has the title "Regression Tester" but is
actually a "compiles and boots tester".  The aim is a automated regression
test.

Take a look at http://altus.drgw.net/

It pulls directly from our BitKeeper archive every time we push a change
and goes through the build targeted for a number of platforms.

} - automated compilation of the kernel with random config
}   options (done by Arjan v/d Ven?)
} - automated testing of certain kernel behaviour (didn't
}   SGI have a project to look at this?  could they use help?)
} - ... ?
