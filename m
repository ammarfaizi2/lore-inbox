Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314029AbSDQNB7>; Wed, 17 Apr 2002 09:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314038AbSDQNB6>; Wed, 17 Apr 2002 09:01:58 -0400
Received: from ns.suse.de ([213.95.15.193]:39688 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314029AbSDQNB5>;
	Wed, 17 Apr 2002 09:01:57 -0400
Date: Wed, 17 Apr 2002 15:01:53 +0200
From: Dave Jones <davej@suse.de>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
Message-ID: <20020417150153.J32185@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Helge Hafting <helgehaf@aitel.hist.no>, Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020415125606.GR12608@suse.de> <02db01c1e498$7180c170$58dc703f@bnscorp.com> <20020416102510.GI17043@suse.de> <3CBD2527.EB976895@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 09:32:55AM +0200, Helge Hafting wrote:
 > I tried it.  It had to run as root to get permission to read.
 > Then it hung the machine - caps & scroll lock blinking.
 > 
 > I can retry it without X (and fs'es remounted r/o) _if_ the
 > resulting crash may help with debugging.

The blinking LEDs indicate you oopsed. Try it without X and you
should see an oops that when decoded may be useful for Jens / Martin.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
