Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313638AbSGUVqg>; Sun, 21 Jul 2002 17:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314340AbSGUVqg>; Sun, 21 Jul 2002 17:46:36 -0400
Received: from ns.suse.de ([213.95.15.193]:28686 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S313638AbSGUVqf>;
	Sun, 21 Jul 2002 17:46:35 -0400
Date: Sun, 21 Jul 2002 23:49:42 +0200
From: Dave Jones <davej@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.27 build errors - linux/i2c-old.h
Message-ID: <20020721234942.A27749@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	linux-kernel@vger.kernel.org
References: <20020721214537.GA24886@ksu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020721214537.GA24886@ksu.edu>; from trelane@jakob.neurotek.dyndns.org on Sun, Jul 21, 2002 at 04:45:37PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2002 at 04:45:37PM -0500, Johnny Q. Hacker wrote:
 > Hello.
 > 
 > We're moving, or I'd track thisone down meself.  I'd guess that it'll
 >   be fairly easy to rectify.

the i2c-old.h using files are broken and need updating to the new i2c
API. There are some conversions done already in the -dj tree.
I'll upload a .27-dj1 in a few minutes..

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
