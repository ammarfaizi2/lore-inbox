Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbVHHQkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbVHHQkp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 12:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbVHHQkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 12:40:45 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.123]:3792 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S932108AbVHHQko
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 12:40:44 -0400
Subject: Re: [linux-audio-dev] Re: any update on the pcmcia bug blocking
	Audigy2 notebook sound card driver development
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>
Cc: Raymond Lai <raymond.kk.lai@gmail.com>, linux-pcmcia@lists.infradead.org,
       alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050807104332.320aec48.akpm@osdl.org>
References: <1ed860e3050807084449b0daac@mail.gmail.com>
	 <20050807104332.320aec48.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1123519224.16205.5.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Aug 2005 09:40:24 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-07 at 10:43, Andrew Morton wrote:
> Raymond Lai <raymond.kk.lai@gmail.com> wrote:
> > Hi all,
> > 
> > I remember there's a kernel pcmcia bug preventing the development for 
> > the Audigy2 pcmcia notebook sound card driver. 
> > 
> > See http://www.alsa-project.org/alsa-doc/index.php?vendor=vendor-Creative_Labs#matrix
> > 
> > Is there any new updates on the situation? Has the bug been fixed? or
> > anyone working on it?
>
> Is it related to http://bugzilla.kernel.org/show_bug.cgi?id=4788 ?

I think not, the card in question is the Creative Audigy 2 ZS PCMCIA
card. I have one I can't use yet :-( The kernel locks hard when ALSA
tries to load the driver. 

This is the last I heard about this issue:
  http://www.uwsg.iu.edu/hypermail/linux/kernel/0507.1/0978.html

-- Fernando


