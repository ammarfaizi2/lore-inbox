Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261493AbRFFJ6N>; Wed, 6 Jun 2001 05:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261515AbRFFJ6E>; Wed, 6 Jun 2001 05:58:04 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:57232 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S261493AbRFFJ57> convert rfc822-to-8bit; Wed, 6 Jun 2001 05:57:59 -0400
Date: Wed, 6 Jun 2001 10:57:57 +0100 (BST)
From: "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>
To: Sean Hunter <sean@dev.sportingbet.com>
cc: Xavier Bestel <xavier.bestel@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <20010606095431.C15199@dev.sportingbet.com>
Message-ID: <Pine.SOL.3.96.1010606103559.20297A-100000@draco.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2001, Sean Hunter wrote:

> 
> For large memory boxes, this is ridiculous.  Should I have 8GB of swap?
> 

Do I understand you correctly?
ECC grade SDRAM for your 8GB server costs £335 per GB as 512MB sticks even
at today's silly prices (Crucial). Ultra160 SCSI costs £8.93/GB as 73GB
drives.

It will cost you 19x as much to put the RAM in as to put the
developer's recommended amount of swap space to back up that RAM.  The
developers gave their reasons for this design some time ago and if the
ONLY problem was that it required you to allocate more swap, why should
it be a priority item to fix it for those that refuse to do so?   By all
means fix it urgently where it doesn't work when used as advised but
demanding priority to fixing a problem encountered when a user refuses to
use it in the manner specified seems very unreasonable.  If you can afford
4GB RAM, you certainly can afford 8GB swap.



