Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289089AbSAGBt0>; Sun, 6 Jan 2002 20:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289088AbSAGBtP>; Sun, 6 Jan 2002 20:49:15 -0500
Received: from gherkin.frus.com ([192.158.254.49]:640 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S289085AbSAGBtG>;
	Sun, 6 Jan 2002 20:49:06 -0500
Message-Id: <m16NOuH-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: Re: weird application breakage in 2.5.2-pre5
In-Reply-To: <20020103172641.D6267@suse.de> "from Jens Axboe at Jan 3, 2002 05:26:41
 pm"
To: Jens Axboe <axboe@suse.de>
Date: Sun, 6 Jan 2002 19:48:57 -0600 (CST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Jan 03 2002, Bob_Tracy wrote:
> > The application is elm2.4.ME+.82 with PGP 6.5.8.  Works fine under
> > kernel version 2.4.17.
> 
> very unlikely I would say, maybe it's an odd scheduler interaction?

I'm happy to report that everything seems to be working fine with
2.5.2-pre9.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
