Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265320AbTA1NB4>; Tue, 28 Jan 2003 08:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265333AbTA1NBz>; Tue, 28 Jan 2003 08:01:55 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:36736
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S265320AbTA1NBy>; Tue, 28 Jan 2003 08:01:54 -0500
Subject: Re: Kernel panic with Red Hat 2-4-18 kernel
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "M. Edward Borasky" <znmeb@aracnet.com>
Cc: "Linux-Kernel@Vger. " "Kernel. Org" <linux-kernel@vger.kernel.org>
In-Reply-To: <DEEBJHMCKLIHOCFBLNCCGEMOCDAA.znmeb@aracnet.com>
References: <DEEBJHMCKLIHOCFBLNCCGEMOCDAA.znmeb@aracnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043759430.1316.43.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 28 Jan 2003 13:10:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-22 at 15:32, M. Edward Borasky wrote:
> Is there a fix available for the following, generated on a 6 GB SMP P4 Xeon
> system with the Red Hat 2.4.18 kernel?
> 
> Kernel panic: Fix pte_chain allocation, you lazy bastard!
> 
> I searched the web and found copious references in the context of 2.5, but
> nothing in 2.4, Red Hat or otherwise.

I'm amazed anyone managed to cause that. With the rmap14 code the answer is
no. The latest rmap15 code in the RH beta should have it resolved

