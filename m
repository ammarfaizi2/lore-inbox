Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263044AbTC0P4d>; Thu, 27 Mar 2003 10:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263062AbTC0P4d>; Thu, 27 Mar 2003 10:56:33 -0500
Received: from smtp1.eunet.yu ([194.247.192.50]:2717 "EHLO smtp1.eunet.yu")
	by vger.kernel.org with ESMTP id <S263044AbTC0P4c>;
	Thu, 27 Mar 2003 10:56:32 -0500
From: Toplica Tanaskovic <toptan@EUnet.yu>
To: James Simmons <jsimmons@infradead.org>
Subject: Re: [REPRODUCABLE BUGS] Linux 2.5.66
Date: Thu, 27 Mar 2003 17:05:23 +0100
User-Agent: KMail/1.5.9
References: <Pine.LNX.4.44.0303262024270.21188-100000@phoenix.infradead.org>
In-Reply-To: <Pine.LNX.4.44.0303262024270.21188-100000@phoenix.infradead.org>
Cc: linux-kernel@vger.kernel.org, thoffman@arnor.net
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200303271705.23957.toptan@EUnet.yu>
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by smtp1.eunet.yu id h2RG7iV26914
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dana sreda 26. mart 2003. 21:24 napisali ste:
> > > For console resizing try using stty cols xxx rows xx.
> >
> > 	Tried.  Not working again. Last line of the text is at same position
> > like when changing mode with fbset, upper lines are now on the right
> > where garbage is when using fbset.
> > 	First scrolling gives an oops, but due to screen corruption I could not
> > write down message displayed. Nothing in logs due to irregular reboot.
>
> I seen this bug. I fixed it in BK.

	Nope, not fixed in BK3 either. Same thing is happening with, and without BK 
patch.

-- 
Pozdrav,
Tanasković Toplica


