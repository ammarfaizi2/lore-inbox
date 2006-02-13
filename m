Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWBMQkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWBMQkc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 11:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWBMQkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 11:40:31 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:49619 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932148AbWBMQk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 11:40:29 -0500
Date: Mon, 13 Feb 2006 17:40:21 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: trudheim@gmail.com, nix@esperi.org.uk, linux-kernel@vger.kernel.org,
       davidsen@tmr.com, axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43F0A1F3.nailKUSV1V88J@burner>
Message-ID: <Pine.LNX.4.61.0602131739440.24297@yvahk01.tjqt.qr>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
 <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr> <20060125153057.GG4212@suse.de>
 <43D7AF56.nailDFJ882IWI@burner> <20060125181847.b8ca4ceb.grundig@teleline.es>
 <20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de>
 <878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com>
 <43F0776F.nailKUS94FU3M@burner> <515e525f0602130446s1091f09ande10910f65a0f5f0@mail.gmail.com>
 <43F0A1F3.nailKUSV1V88J@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Nitpicking I know, but technically, CD-R is WORM in the case of single
>> session write. And as long as the writer works, who cares if it is
>> labled WORM, CD-R or Earthworm..
>
>If you did know what a worm is, you would know that you are not correct:
>
>A WORM allows you to randomly write any sector once.
>A CD-R does not allows you to do this.
>
Nitpicking2, the CD-R case is a limitation of the cd writer ;)
Sadly there is no packet mode for CDRs. It would outbeat multisession.



Jan Engelhardt
-- 
