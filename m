Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264895AbSIWGvs>; Mon, 23 Sep 2002 02:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264897AbSIWGvs>; Mon, 23 Sep 2002 02:51:48 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:43410 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S264895AbSIWGvr>;
	Mon, 23 Sep 2002 02:51:47 -0400
Date: Mon, 23 Sep 2002 08:56:58 +0200
From: bert hubert <ahu@ds9a.nl>
To: "David S. Miller" <davem@redhat.com>
Cc: eran@nbase.co.il, linux-kernel@vger.kernel.org,
       bart.de.schuymer@pandora.be
Subject: Re: Kernel 2.5.38 EBTables breakage
Message-ID: <20020923065658.GA706@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	"David S. Miller" <davem@redhat.com>, eran@nbase.co.il,
	linux-kernel@vger.kernel.org, bart.de.schuymer@pandora.be
References: <3D8D8660.80905@nbase.co.il> <20020922111000.GA17169@outpost.ds9a.nl> <20020922.200913.103735526.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020922.200913.103735526.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2002 at 08:09:13PM -0700, David S. Miller wrote:

>    With the following patch it at least compiles in 2.5.38
>    
> Applied.
> 
> I'm not surprised something went wrong, recall all of the comments
> I had about your patch format Bert?  Different base directories et al.

I think you are mixing up Bert and Bart here - I'm just the HOWTO guy that
found the missing includes and supplied them in patch form. 

I hope these includes matched what was in your tree.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
