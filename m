Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129650AbRBFDgo>; Mon, 5 Feb 2001 22:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129657AbRBFDgf>; Mon, 5 Feb 2001 22:36:35 -0500
Received: from cold.fortyoz.org ([64.40.111.214]:54024 "HELO cold.fortyoz.org")
	by vger.kernel.org with SMTP id <S129650AbRBFDg2>;
	Mon, 5 Feb 2001 22:36:28 -0500
Date: Mon, 5 Feb 2001 19:37:03 -0800
From: David Raufeisen <david@fortyoz.org>
To: Vladimir Kukuruzovic <kuki@sezampro.yu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hpt370
Message-ID: <20010205193703.A26178@fortyoz.org>
Reply-To: David Raufeisen <david@fortyoz.org>
In-Reply-To: <NEBBKCIPKLPNDBIKKMBACENIFFAA.kuki@sezampro.yu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <NEBBKCIPKLPNDBIKKMBACENIFFAA.kuki@sezampro.yu>; from "Vladimir Kukuruzovic" on Tuesday, 06 February 2001, at 02:38:29 (+0100)
X-Operating-System: Linux 2.2.17 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Booted fine on a box I installed 2.4.1 on..

On Tuesday, 06 February 2001, at 02:38:29 (+0100),
Vladimir Kukuruzovic wrote:

> Hi,
> Maybe you don't know, but current Linux kernel (starting somewhere in
> testNN, probably test10 series) won't boot with HPT370 controller. With
> current setup (only one disk on that controller, no raid, no fancy stuff)
> the kernel locks after writing ide2: line :( Well, it used to work earlier,
> can it be unpatched so it starts working again? :)
> 
> Regards, Vladimir
> 

-- 
David Raufeisen <david@fortyoz.org>
Cell: (604) 818-3596
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
