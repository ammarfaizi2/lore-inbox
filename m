Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267141AbSLRPSm>; Wed, 18 Dec 2002 10:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267143AbSLRPSm>; Wed, 18 Dec 2002 10:18:42 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:32999
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267141AbSLRPSl>; Wed, 18 Dec 2002 10:18:41 -0500
Subject: Re: 2.5.51 ide module problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: Andre Hedrick <andre@linux-ide.org>, axboe@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200212181414.GAA02717@adam.yggdrasil.com>
References: <200212181414.GAA02717@adam.yggdrasil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Dec 2002 16:07:00 +0000
Message-Id: <1040227620.24530.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-18 at 14:14, Adam J. Richter wrote:
> 	I'd appreciate some clarification on what trouble the generic
> IDE driver can get into when the cmd640 code is not present.
> linux-2.5.52/Documentation/ide.txt says:

I'll get back to 2.5 IDE things next year. For the moment I'm only
concerned in getting the modular stuff sorted out completely in 2.4.
Hopefully that will be mostly valid for 2.5 as well.

CMD640 has hooks into the code that need generalising and cleaning up.

Alan

