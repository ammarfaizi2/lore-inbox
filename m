Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAIXtj>; Tue, 9 Jan 2001 18:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbRAIXt3>; Tue, 9 Jan 2001 18:49:29 -0500
Received: from unthought.net ([212.97.129.24]:11940 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S129406AbRAIXtT>;
	Tue, 9 Jan 2001 18:49:19 -0500
Date: Wed, 10 Jan 2001 00:49:17 +0100
From: Jakob Østergaard <jakob@unthought.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Hubert Mantel <mantel@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Change of policy for future 2.2 driver submissions
Message-ID: <20010110004917.A861@unthought.net>
Mail-Followup-To: Jakob Østergaard <jakob@unthought.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Hubert Mantel <mantel@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010109154908.F20539@suse.de> <E14G0Ag-0006ko-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <E14G0Ag-0006ko-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Jan 09, 2001 at 02:54:44PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 02:54:44PM +0000, Alan Cox wrote:
> > some official 2.2 kernel. In order to make it possible to switch between
> > kernel releases, every vendor now really is forced to integrate the new
> > RAID0.90 code to their 2.2 kernel. IMHO this code should be integrated to
> > the next official 2.2 kernel so people can use whatever they want.
> 
> Then people using a newer 2.2 cannot go back to an older 2.2 thats really
> far far worse.

And don't forget, the 0.90 patches are available for 2.2 - so 2.2
can do 0.90 Software RAID just fine.

Besides, most people using Software RAID have been using 0.90 for
at least two years - so I doubt this would have been much of a problem
if the 0.90 patches weren't available for 2.2, which they are.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
