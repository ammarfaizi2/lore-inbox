Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289017AbSANUWy>; Mon, 14 Jan 2002 15:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289010AbSANUVY>; Mon, 14 Jan 2002 15:21:24 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:19196 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S289020AbSANUUb>;
	Mon, 14 Jan 2002 15:20:31 -0500
Date: Mon, 14 Jan 2002 13:20:14 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Matt Domsch <Matt_Domsch@Dell.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] GUID Partition Tables
Message-ID: <20020114132014.S26688@lynx.adilger.int>
Mail-Followup-To: Matt Domsch <Matt_Domsch@Dell.com>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <71714C04806CD511935200902728921702E3AB-100000@ausxmrr502.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <71714C04806CD511935200902728921702E3AB-100000@ausxmrr502.us.dell.com>; from Matt_Domsch@Dell.com on Mon, Jan 14, 2002 at 01:49:14PM -0600
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 14, 2002  13:49 -0600, Matt Domsch wrote:
> I'm also working with Andreas Dilger who is moving all fs/partitions/* 
> code into util-linux/partx.  Until that is ready though, I'd like to see 
> this patch in the 2.5.x tree.  This will avoid needing this common code in 
> the IA-64 port patch indefinitely.

s/Andreas Dilger/Andries Brouwer/ I think.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

