Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285273AbRLVALd>; Fri, 21 Dec 2001 19:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285230AbRLVALS>; Fri, 21 Dec 2001 19:11:18 -0500
Received: from gherkin.frus.com ([192.158.254.49]:12418 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S285134AbRLVALM>;
	Fri, 21 Dec 2001 19:11:12 -0500
Message-Id: <m16HZkl-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: Re: sr: unaligned transfer
In-Reply-To: <20011221230711.E2929@suse.de> "from Jens Axboe at Dec 21, 2001
 11:07:11 pm"
To: Jens Axboe <axboe@kernel.org>
Date: Fri, 21 Dec 2001 18:11:03 -0600 (CST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, Dec 21 2001, Bob_Tracy wrote:
> > Jens Axboe wrote:
> > > On Fri, Dec 21 2001, Bob_Tracy wrote:
> > > > 	sr: unaligned transfer
> > > > 	Unable to identify CD-ROM format.
> >
> > > Please try and mount with -o loop instead.
> 
> mount -o loop -t iso9660 /dev/scd1 /mnt

I still get the "sr: unaligned transfer" message, and as an added bonus,
the mount hangs...  Can't interrupt it, can't kill it :-(.

Next? :-)

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
