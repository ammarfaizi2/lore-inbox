Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293351AbSB1Onf>; Thu, 28 Feb 2002 09:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293357AbSB1OlG>; Thu, 28 Feb 2002 09:41:06 -0500
Received: from mallaury.noc.nerim.net ([62.4.17.82]:50449 "HELO
	mallaury.noc.nerim.net") by vger.kernel.org with SMTP
	id <S293354AbSB1Ojm>; Thu, 28 Feb 2002 09:39:42 -0500
Date: Thu, 28 Feb 2002 15:39:39 +0100
To: Urban Widmark <urban@teststation.com>
Cc: linux-kernel@vger.kernel.org,
        Christian =?iso-8859-15?Q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
Subject: Re: [2.4.18] OOPS in smbfs
Message-ID: <20020228143939.GA13616@calixo.net>
In-Reply-To: <20020227080024.GA16232@calixo.net> <Pine.LNX.4.33.0202281507560.32098-100000@cola.teststation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.33.0202281507560.32098-100000@cola.teststation.com>
User-Agent: Mutt/1.3.27i
X-Face: "99`N"mZV/:<T->OLp[>#d3R;u.!ivtwAEpIQDL8rD#;L3Wm)~^)Uv=#;S!LZf1y8oRY7J#JR\Lr{*4Cn*32C89ln>0~5~tm--}j%hvhj+vtW><xbwA=@G8M||zPV0-r`:6zhMqq+_OC_0W*-:Wxzm3%|A5EE}VFnIgRU=+,L-hGdM"j&l'_^zK+%MBOsdmi#e3(3fGg^SGM
From: Cyrille Chepelov <cyrille@chepelov.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Thu, Feb 28, 2002, à 03:34:53PM +0100, Urban Widmark a écrit:

> Does 2.4.17 work fine for everyone?
> Did any of you try something between 2.4.18-pre4 and 2.4.18-rc2?

Previously, that machine was running 2.4.17-pre8. It was running fine with
smbfs, but had never been asked to touch the NT server I mentioned. OTOH,
with the 2.4.18-rc4 kernel, I can touch other Win2K (workstation) machines
with no harmful effects.

I would like to avoid going back to 2.4.18-rc2 (lack of time to compile), if
someone with identical oopes had the time the better. But if no-one does
before tomorrow, I'll try that version.

	-- Cyrille

-- 
Grumpf.

