Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271712AbRIEF7v>; Wed, 5 Sep 2001 01:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271714AbRIEF7l>; Wed, 5 Sep 2001 01:59:41 -0400
Received: from are.twiddle.net ([64.81.246.98]:63109 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S271712AbRIEF7Z>;
	Wed, 5 Sep 2001 01:59:25 -0400
Date: Tue, 4 Sep 2001 22:59:42 -0700
From: Richard Henderson <rth@twiddle.net>
To: Bob McElrath <mcelrath@draal.physics.wisc.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Wrong BogoMIPS on alpha
Message-ID: <20010904225942.A19434@twiddle.net>
Mail-Followup-To: Bob McElrath <mcelrath@draal.physics.wisc.edu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20010904101318.B1458@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010904101318.B1458@draal.physics.wisc.edu>; from mcelrath@draal.physics.wisc.edu on Tue, Sep 04, 2001 at 10:13:18AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2001 at 10:13:18AM -0500, Bob McElrath wrote:
> Recently the bogomips measurement has gone all haywire.  Every once in a
> while when I boot up the bogomips measurement will be absurly high (i.e.
> 5 Terahertz), with obvious associated problems.
[...]
> The system is:
> Alpha LX164 (21164 chip) at 600MHz

Your clock chip has gone bad.  This happens regularly
with the shitty chip they put in LX and SX systems.


r~
