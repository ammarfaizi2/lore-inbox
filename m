Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278275AbRKMTHC>; Tue, 13 Nov 2001 14:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278309AbRKMTGw>; Tue, 13 Nov 2001 14:06:52 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:53764 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S278275AbRKMTGf>; Tue, 13 Nov 2001 14:06:35 -0500
Date: Tue, 13 Nov 2001 14:06:22 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: Re: [PATCH] Next cut of new devfs core
Message-ID: <20011113140622.B17578@redhat.com>
In-Reply-To: <200111131855.fADIt2Q26535@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200111131855.fADIt2Q26535@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Tue, Nov 13, 2001 at 11:55:02AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2001 at 11:55:02AM -0700, Richard Gooch wrote:
>   Hi, all. Another cut of the new devfs core. Better debugging and a
> devfsd notification race was fixed.
> 
> If people could try this out and report back, I'd appreciate it.
> 
> Patch against 2.4.14, and applies cleanly against 2.4.15-pre4.

Could you set your editor to emit <tab> charaters for indentation?  Most 
editors I know of let you set the display of tabs to 4 charaters if that 
is your preference, but sticking to spaces is just ugly.

		-ben
