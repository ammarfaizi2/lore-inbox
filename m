Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263850AbUECSsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbUECSsD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 14:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263864AbUECSsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 14:48:03 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:33545 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263850AbUECSr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 14:47:59 -0400
Date: Mon, 3 May 2004 19:47:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mariusz Mazur <mmazur@kernel.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.5.1
Message-ID: <20040503194757.A13711@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mariusz Mazur <mmazur@kernel.pl>, linux-kernel@vger.kernel.org
References: <200405030111.49802.mmazur@kernel.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200405030111.49802.mmazur@kernel.pl>; from mmazur@kernel.pl on Mon, May 03, 2004 at 01:11:49AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 01:11:49AM +0200, Mariusz Mazur wrote:
> Available at http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
> Changes:
> - network headers got fixed - most notably removed most common collisions 
> between glibc and llh (I hate making hacks, but don't have much choice - 
> glibc's network headers lack functionality); iproute2 and iputils should 
> build with just small patches (which can be found at the above url) and 
> including linux/{in*,if*} in general should be quite safe now

Maybe someone should spend some time and fix up the glibc headers instead? :)

