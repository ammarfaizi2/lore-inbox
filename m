Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129061AbQKMIdA>; Mon, 13 Nov 2000 03:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129135AbQKMIcu>; Mon, 13 Nov 2000 03:32:50 -0500
Received: from mail.zmailer.org ([194.252.70.162]:48905 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129061AbQKMIci>;
	Mon, 13 Nov 2000 03:32:38 -0500
Date: Mon, 13 Nov 2000 10:32:31 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: david+validemail@kalifornia.com
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status/TODO page (test11-pre3)
Message-ID: <20001113103231.B28963@mea-ext.zmailer.org>
In-Reply-To: <200011121939.eACJd9D01319@trampoline.thunk.org> <3A0F5F6D.F8B26CDF@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A0F5F6D.F8B26CDF@linux.com>; from david@linux.com on Sun, Nov 12, 2000 at 07:26:37PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2000 at 07:26:37PM -0800, David Ford wrote:
> tytso@mit.edu wrote:
> > Fixed
> >      * Incredibly slow loopback tcp bug (believed fixed about 2.3.48)
> 
> Note; if I set up ESD to listen on a tcp port, connecting locally sounds
> horrible.  I haven't looked to see who's fault it really is.

	FTP-transfer of large file over loopback gives me about 80 MB/sec
	speeds at 2.4.0-test8 -- nor is the ESD bad sounding.

	However my Alpha has the SB support very bad sounding..
	It sounds like spectrum reversal, in fact -- first noticed
	when playing stereophonic MP3 with xmms, but when same file
	was played to .WAV file at an intel box (where it sounds quite
	ok), and that wav is play(1)ed at the alpha -- same bad sound.

> -d

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
