Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310199AbSCEUfK>; Tue, 5 Mar 2002 15:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310201AbSCEUfB>; Tue, 5 Mar 2002 15:35:01 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:51865 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S310199AbSCEUep>;
	Tue, 5 Mar 2002 15:34:45 -0500
Date: Tue, 5 Mar 2002 15:34:42 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Pavel Machek <pavel@suse.cz>
cc: Rik van Riel <riel@conectiva.com.br>, Rakesh Kumar Banka <Rakesh@asu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: Monolithic Vs. Microkernel
In-Reply-To: <20020304144923.A96@toy.ucw.cz>
Message-ID: <Pine.GSO.4.21.0203051533160.18755-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Mar 2002, Pavel Machek wrote:

> Not *all* of them. On vsta, you could do
> 
> ( killall keyboard; sleep 1; keyboard ) &
> 
> to change your keymap. On linux you need special tools for managing
> modules and are not protected from module bugs. Try developing filesystem
> on production box.... You can do that on u-kernels.

Userland filesystems != microkernel.

