Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277100AbRJHTkY>; Mon, 8 Oct 2001 15:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277099AbRJHTkO>; Mon, 8 Oct 2001 15:40:14 -0400
Received: from anime.net ([63.172.78.150]:38916 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S277108AbRJHTkC>;
	Mon, 8 Oct 2001 15:40:02 -0400
Date: Mon, 8 Oct 2001 12:40:06 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Roy-Magne Mo <rmo@sunnmore.net>
cc: Willem Riede <wriede@home.com>, Steven Walter <srwalter@yahoo.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Tyan Tiger MP AMD760 chipset support
In-Reply-To: <20011007223400.C8033@akkar.interpost.no>
Message-ID: <Pine.LNX.4.30.0110081239320.22178-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Oct 2001, Roy-Magne Mo wrote:
> I can with these modules detect the eeprom, the AMD756 and the
> winbond W83782D.
> But, however, inserting the winbond driver locks the computer hard.

It's a bug in the lm_sensors winbond driver. There's been a patch posted
in the bugtracker but afaik hasn't been integrated into cvs yet...

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

