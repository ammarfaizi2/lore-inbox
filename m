Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273652AbRIWOxs>; Sun, 23 Sep 2001 10:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273656AbRIWOxl>; Sun, 23 Sep 2001 10:53:41 -0400
Received: from stine.vestdata.no ([195.204.68.10]:8869 "EHLO stine.vestdata.no")
	by vger.kernel.org with ESMTP id <S273652AbRIWOxb>;
	Sun, 23 Sep 2001 10:53:31 -0400
Date: Sun, 23 Sep 2001 16:53:29 +0200
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: rojesh p <rojesh_p@rediffmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: multiple ethernet load balancing
Message-ID: <20010923165329.A23635@vestdata.no>
In-Reply-To: <20010923145613.24235.qmail@mailFA9.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010923145613.24235.qmail@mailFA9.rediffmail.com>; from rojesh_p@rediffmail.com on Sun, Sep 23, 2001 at 02:56:13PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2001 at 02:56:13PM -0000, rojesh  p wrote:
> hello,
>       i am trying to develop a ethernet driver for using more than one ethernet card per machine so that i can increase the speed of the network.i am writing the driver for ne2000 ethernet card. can anyone help in finding the necessary details relating to my project. has anybody written the dirver for multiple ethernet cards which transmit data simultaneously.if so where can i find the source code.


http://bonding.sourceforge.net/



-- 
Ragnar Kjørstad
Big Storage
