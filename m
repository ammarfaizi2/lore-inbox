Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318526AbSHIMVG>; Fri, 9 Aug 2002 08:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318529AbSHIMVG>; Fri, 9 Aug 2002 08:21:06 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:43017 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318526AbSHIMVF>; Fri, 9 Aug 2002 08:21:05 -0400
Date: Fri, 9 Aug 2002 13:24:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Johan Martensson <a0087901@levonline.com>
Cc: linux-kernel@vger.kernel.org, jom@virrvarr.com
Subject: Re: 2.4.19 Oops :Unable to handle kernel paging request
Message-ID: <20020809132447.A9306@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Johan Martensson <a0087901@levonline.com>,
	linux-kernel@vger.kernel.org, jom@virrvarr.com
References: <Pine.LNX.4.44.0208091334100.3991-100000@utter.levonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208091334100.3991-100000@utter.levonline.com>; from a0087901@levonline.com on Fri, Aug 09, 2002 at 02:17:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2002 at 02:17:22PM +0200, Johan Martensson wrote:
> One of our machines running linux 2.4.19 with grsecurity 1.9.6 got an Oops 
> last night. I'm sorry if it is obvious that this is caused by grsecurity 
> and wouldn't happen with vanilla 2.4.19 (I'm too stupid to tell:)).

At least the oops is in the grsecurity code.  I'd contact it's developers
first.

