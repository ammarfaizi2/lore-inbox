Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265414AbSKFAJy>; Tue, 5 Nov 2002 19:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265419AbSKFAJy>; Tue, 5 Nov 2002 19:09:54 -0500
Received: from gate.in-addr.de ([212.8.193.158]:20238 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S265414AbSKFAJw>;
	Tue, 5 Nov 2002 19:09:52 -0500
Date: Wed, 6 Nov 2002 01:16:07 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Kevin Corry <corryk@us.ibm.com>, evms-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Evms-announce] EVMS announcement
Message-ID: <20021106001607.GJ27832@marowsky-bree.de>
References: <02110516191004.07074@boiler>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02110516191004.07074@boiler>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-11-05T16:19:10,
   Kevin Corry <corryk@us.ibm.com> said:

Kevin,

this must have been a very painful decision. I publically applaud you for
making it.

The great benefit from EVMS is the unified toolset for the administrator. It
is impressive that you are willing to rework this on top of a "Not Invented
Here" framework. I'm not sure whether my ego would have allowed the same
decision ;-)

The Device-Mapper seems to appeal more to the kernel community (and I'll agree
it is quite impressively neat code), and the EVMS management aspect appeals to
users. I hope that merging these will appeal to all. (It certainly does to
me).

I'm most certainly looking forward to seeing the clustering support comeing
;-)

Now, an interesting question is whether the md modules etc will simply be
continued to be used or whether they'll make use of the DM engine too? Can
they be made "plugins" to DM or the EVMS framework? Or even, could EVMS (in
theory) parse the meta-data from a legacy md device and just setup a DM
mapping for it? That would appeal to me quite a bit. I really need to start
reading up on it...


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Principal Squirrel 
SuSE Labs - Research & Development, SuSE Linux AG
  
"If anything can go wrong, it will." "Chance favors the prepared (mind)."
  -- Capt. Edward A. Murphy            -- Louis Pasteur
