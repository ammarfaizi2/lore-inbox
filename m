Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266599AbRGLVN4>; Thu, 12 Jul 2001 17:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266595AbRGLVNq>; Thu, 12 Jul 2001 17:13:46 -0400
Received: from a27-170.dialup.iol.cz ([194.228.170.27]:26061 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S266562AbRGLVNl>;
	Thu, 12 Jul 2001 17:13:41 -0400
Date: Thu, 12 Jul 2001 23:10:55 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Mike Harrold <mharrold@cas.org>
Cc: linux-kernel@alex.org.uk, David Woodhouse <dwmw2@infradead.org>,
        torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] More pedantry.
Message-ID: <20010712231055.A5794@suse.cz>
In-Reply-To: <520087372.994974550@[169.254.45.213]> <200107122058.QAA15963@mah21awu.cas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200107122058.QAA15963@mah21awu.cas.org>; from mharrold@cas.org on Thu, Jul 12, 2001 at 04:58:45PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2001 at 04:58:45PM -0400, Mike Harrold wrote:
> > 
> > > - *		None of the E1AP-E3AP erratas are visible to the user.
> > > + *		None of the E1AP-E3AP errata are visible to the user.
> > 
> > If you want real pedantry, I think you mean:
> > 
> > > + *		None of the E1AP-E3AP errata is visible to the user.
> > 
> > ('none' is singular - read 'not one')
> > 
> > ... several times within this patch.
> 
> No, he was right the first time. Errata is plural. Erratum is the
> singular.

Yes, but the subject of the sentence is 'none'. Thus the verb should be
in singular: None of them *is* visible.

But perhaps my version of english is different from yours. I learned
mine from textbooks.

-- 
Vojtech Pavlik
SuSE Labs
