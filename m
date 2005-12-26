Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbVLZEJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbVLZEJK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 23:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbVLZEJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 23:09:10 -0500
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:33142 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750988AbVLZEJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 23:09:09 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: mouse issues in 2.6.15-rc5-mm series
Date: Sun, 25 Dec 2005 23:09:06 -0500
User-Agent: KMail/1.9.1
Cc: Marc Koschewski <marc@osknowledge.org>, Joe Feise <jfeise@feise.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <43ACEE14.7060507@feise.com> <20051224104224.GA5789@stiffy.osknowledge.org> <43AD29A6.10407@tuxrocks.com>
In-Reply-To: <43AD29A6.10407@tuxrocks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512252309.07162.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 December 2005 05:57, Frank Sorenson wrote:
> 
> I continue to see the same issues with the resync patch in -mm.  For me,
> tapping stops working, and I'm now seeing both the mouse pointer jumping
>  as well (a lesser issue for me, so it was probably present earlier as
> well).
> 

Frank,

Does the tapping not work period or it only does not work first time you
try to tap after not touching the pad for more than 5 seconds?

-- 
Dmitry
