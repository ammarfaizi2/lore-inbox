Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280674AbRKBM5B>; Fri, 2 Nov 2001 07:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280678AbRKBM4v>; Fri, 2 Nov 2001 07:56:51 -0500
Received: from danielle.hinet.hr ([195.29.254.157]:56980 "EHLO
	danielle.hinet.hr") by vger.kernel.org with ESMTP
	id <S280674AbRKBM4p>; Fri, 2 Nov 2001 07:56:45 -0500
Date: Fri, 2 Nov 2001 13:56:40 +0100
From: Mario Mikocevic <mozgy@hinet.hr>
To: Wouter van Bommel <WvanBommel@jasongeo.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: SMP machine with 2GB ram hangs without any clue
Message-ID: <20011102135640.A1041@danielle.hinet.hr>
In-Reply-To: <7141CF666EB1D411AF4A004854550BBC088DBE@dexter.jason.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <7141CF666EB1D411AF4A004854550BBC088DBE@dexter.jason.nl>; from WvanBommel@jasongeo.com on Mon, Oct 29, 2001 at 07:10:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> I am hoping someone can help me with picking the right (read stable) kernel for the following hardware configuration:
> 2x 1Ghz PIII fitted on a serverworks chipset, and 2GB ram.
> Video Card is an Geforce MX-400 twinview setup (no agp, several Geforce cards tried)
> Network is an intergrated intel ether express (eepro100 driver)

If we count out video card for me the best combo so far is
	2.4.9 kernel with intel e100-1.6.13
never had a single problem with it.
(several servers, realmeadia/web/file servers, some with teaming/redundancy ethXs)

-- 
Mario Mikoèeviæ (Mozgy)
mozgy at hinet dot hr
My favourite FUBAR ...
