Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267550AbSLMAhR>; Thu, 12 Dec 2002 19:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267568AbSLMAhR>; Thu, 12 Dec 2002 19:37:17 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:29970 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267550AbSLMAhQ>;
	Thu, 12 Dec 2002 19:37:16 -0500
Date: Thu, 12 Dec 2002 16:43:30 -0800
From: Greg KH <greg@kroah.com>
To: Valdis.Kletnieks@vt.edu
Cc: Alessandro Suardi <alessandro.suardi@oracle.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.5[01]]: Xircom Cardbus broken (PCI resource collisions)
Message-ID: <20021213004330.GG23509@kroah.com>
References: <200212122247.gBCMlHgY011021@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212122247.gBCMlHgY011021@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2002 at 05:47:17PM -0500, Valdis.Kletnieks@vt.edu wrote:
> > PCI: Device 02:00.0 not available because of resource collisions
> > PCI: Device 02:00.1 not available because of resource collisions
> 
> Been there. Done that. Does the attached patch help? It did for me.

Fixes the problem for me :)

thanks for the patch,

greg k-h
