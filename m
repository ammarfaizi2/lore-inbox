Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276135AbRJYUAs>; Thu, 25 Oct 2001 16:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276138AbRJYUAi>; Thu, 25 Oct 2001 16:00:38 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:8406 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S276135AbRJYUAc>; Thu, 25 Oct 2001 16:00:32 -0400
Date: Thu, 25 Oct 2001 16:01:03 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Samium Gromoff <_deepfire@mail.ru>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.12-ac4 10Mbit NE2k interrupt load kills p166
Message-ID: <20011025160103.I23000@redhat.com>
In-Reply-To: <200110251930.f9PJUJl26883@vegae.deep.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110251930.f9PJUJl26883@vegae.deep.net>; from _deepfire@mail.ru on Thu, Oct 25, 2001 at 11:30:18PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2001 at 11:30:18PM +0400, Samium Gromoff wrote:
>        Hello folks...
> 
> 	Host A: p166, ISA NE2K, linux-2.4.12-ac4
> 	Host B: p2-400, rtl-8129, WinXP (heh, not my box though ;)
> 
> 	Load: smbmount connection from host A to the host B, and getting
>      large files.

Solution: replace NE2K with a decent network card.

		-ben
