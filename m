Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268214AbTBNFy1>; Fri, 14 Feb 2003 00:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268215AbTBNFy1>; Fri, 14 Feb 2003 00:54:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7173 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S268214AbTBNFy0>;
	Fri, 14 Feb 2003 00:54:26 -0500
Message-ID: <3E4C86C5.306@pobox.com>
Date: Fri, 14 Feb 2003 01:03:49 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Ion Badulescu <ionut@badula.org>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [net drvr] starfire driver update for 2.5.60
References: <Pine.LNX.4.44.0302132158160.3318-100000@moisil.badula.org>
In-Reply-To: <Pine.LNX.4.44.0302132158160.3318-100000@moisil.badula.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:
> 
> But I'd like to hear first if my previous mail addressed your concerns.  
> BTW, if I didn't make it clear enough: that 4 slot reservation is an
> optimization, not a workaround -- it would work correctly even without it,
> but you'd get really sucky behavior with SG skbuffs.


It's merged, so I will study it at my leisure, and write up comments :)

