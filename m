Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267527AbRGXNaS>; Tue, 24 Jul 2001 09:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267533AbRGXNaI>; Tue, 24 Jul 2001 09:30:08 -0400
Received: from cp912944-a.mtgmry1.md.home.com ([24.18.149.178]:12930 "EHLO
	zalem.puupuu.org") by vger.kernel.org with ESMTP id <S267527AbRGXN37>;
	Tue, 24 Jul 2001 09:29:59 -0400
Date: Tue, 24 Jul 2001 09:30:00 -0400
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org, linux-fsdev@vger.kernel.org
Subject: Re: Yet another linux filesytem: with version control
Message-ID: <20010724093000.A1331@zalem.puupuu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-fsdev@vger.kernel.org
In-Reply-To: <3B5CADD7.7C7C8337@wanadoo.fr> <Pine.LNX.4.33L.0107232027120.20326-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33L.0107232027120.20326-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Mon, Jul 23, 2001 at 08:30:48PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 23, 2001 at 08:30:48PM -0300, Rik van Riel wrote:
> You already have:
> 1) Source Control Management system (SCM)
> 2) Userland NFS daemon (UNFSD)
> 3) network layer
> 4) NFS filesystem support (for every OS!)
> 
> All you need is a backend for the NFS server daemon to
> get its files from a version control system (the SCM)
> instead of from disk.

Stupid question maybe, but if you already have knfsd running on the
box serving perfectly normal directories (no unheard of with servers
after all), how do you tie in your own userland nfs server?

  OG.

