Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285344AbRLSQCM>; Wed, 19 Dec 2001 11:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285355AbRLSQCB>; Wed, 19 Dec 2001 11:02:01 -0500
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:52498 "EHLO
	moria.gondor.com") by vger.kernel.org with ESMTP id <S285344AbRLSQBq>;
	Wed, 19 Dec 2001 11:01:46 -0500
Date: Wed, 19 Dec 2001 17:01:43 +0100
From: Jan Niehusmann <jan@gondor.com>
To: Brendan Pike <spike@superweb.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE Harddrive Performance
Message-ID: <20011219160143.GA8658@gondor.com>
In-Reply-To: <20011219153233.GA3424@leukertje.hitnet.rwth-aachen.de> <01121911444703.31762@spikes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01121911444703.31762@spikes>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2001 at 11:44:47AM -0400, Brendan Pike wrote:
> I dont really know, I dont think its possible to get higher then that from a 
> 5400 RPM disk. Heres mine,

/dev/hda:
 Timing buffered disk reads:  64 MB in  2.32 seconds = 27.59 MB/sec

bash-2.05a# cat /proc/ide/hda/model 
Maxtor 98196H8

This is a 5400rpm drive, too.

Jan

