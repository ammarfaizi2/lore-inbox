Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262092AbRENMpK>; Mon, 14 May 2001 08:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262062AbRENMpA>; Mon, 14 May 2001 08:45:00 -0400
Received: from pc1-hems4-0-cust171.bre.cable.ntl.com ([213.105.88.171]:46575
	"HELO rhirst.linuxcare.com") by vger.kernel.org with SMTP
	id <S262061AbRENMow>; Mon, 14 May 2001 08:44:52 -0400
Date: Mon, 14 May 2001 13:43:39 +0100
From: Richard Hirst <rhirst@linuxcare.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [NEW SCSI DRIVER] for 53c700 chip and NCR_D700 card against 2.4.4
Message-ID: <20010514134339.D24646@linuxcare.com>
In-Reply-To: <UTC200105132357.BAA40155.aeb@vlet.cwi.nl> <200105140055.TAA00817@jet.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0us
In-Reply-To: <200105140055.TAA00817@jet.il.steeleye.com>; from James.Bottomley@HansenPartnership.com on Sun, May 13, 2001 at 07:55:55PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2001 at 07:55:55PM -0500, James Bottomley wrote:
> The next chip core I'm considering is the 720/770 (I have a nice microchannel card with 4 of these and 2MB of onboard memory), unless you know of someone who has already done the extra work (the 53c7xx and 53c7,8xx don't do the wide/ultra features).

I have modified ncr53c8xx.c to work with 53c720, again in the
parisc-liunx tree.

Richard

