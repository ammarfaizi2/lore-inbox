Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287751AbSBGMs1>; Thu, 7 Feb 2002 07:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287769AbSBGMsT>; Thu, 7 Feb 2002 07:48:19 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:28270 "HELO
	mailhub.stusta.mhn.de") by vger.kernel.org with SMTP
	id <S287751AbSBGMrn>; Thu, 7 Feb 2002 07:47:43 -0500
Date: Thu, 7 Feb 2002 13:47:37 +0100
From: "Oliver M . Bolzer" <oliver@gol.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ?????????????????????
Message-ID: <20020207134737.A1663@magi.fakeroot.net>
In-Reply-To: <OF364AD35A.0EC28B68-ON86256B58.000D6156@hometownamerica.net> <0GR400G9IRB2XW@mtaout03.icomcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Mutt/1.2.4i-jp0
In-Reply-To: <0GR400G9IRB2XW@mtaout03.icomcast.net>; from hiryuu@envisiongames.net on Wed, Feb 06, 2002 at 04:21:50PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 04:21:50PM -0500, Brian <hiryuu@envisiongames.net> wrote...
> Can we get something like 
> 	/[\200-\377]{6}/   (6 upper ACSII characters in a row)
> added to the taboo list?

If you mean to match a header like Subject: , don't forget to
decode them first. Usually, headers containing these are MIME-encoded.

-- 
	Oliver M. Bolzer
	oliver@gol.com

GPG (PGP) Fingerprint = 621B 52F6 2AC1 36DB 8761  018F 8786 87AD EF50 D1FF
