Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263211AbRFFNwA>; Wed, 6 Jun 2001 09:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263218AbRFFNvu>; Wed, 6 Jun 2001 09:51:50 -0400
Received: from elektra.higherplane.net ([203.37.52.137]:24480 "EHLO
	elektra.higherplane.net") by vger.kernel.org with ESMTP
	id <S263217AbRFFNvn>; Wed, 6 Jun 2001 09:51:43 -0400
Date: Thu, 7 Jun 2001 00:06:29 +1000
From: john slee <indigoid@higherplane.net>
To: "David N. Welton" <davidw@apache.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: temperature standard - global config option?
Message-ID: <20010607000629.B3742@higherplane.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87snhdvln9.fsf@apache.org>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Jun 06, 2001 at 02:27:22PM +0200, David N. Welton wrote:
> Perusing the kernel sources while investigating watchdog drivers, I
> notice that in some places, Fahrenheit is used, and in some places,
> Celsius.  It would seem logical to me to have a global config option,
> so that you *know* that you talk devices either in F or C.

celsius is probably a sensible default - lots of the world uses it now.

j.

-- 
"Bobby, jiggle Grandpa's rat so it looks alive, please" -- gary larson
