Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267033AbSLXBrI>; Mon, 23 Dec 2002 20:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267034AbSLXBrI>; Mon, 23 Dec 2002 20:47:08 -0500
Received: from jstevenson.plus.com ([212.159.71.212]:37791 "EHLO
	alpha.stev.org") by vger.kernel.org with ESMTP id <S267033AbSLXBrI>;
	Mon, 23 Dec 2002 20:47:08 -0500
Subject: Re: is there a disc in the drive?
From: James Stevenson <james@stev.org>
To: Adam Hunt <adam.r.hunt@gmx.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <21811.1040677323@www3.gmx.net>
References: <21811.1040677323@www3.gmx.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 24 Dec 2002 01:55:25 +0000
Message-Id: <1040694925.1459.0.camel@god.stev.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

open the cd drive in non blocking mode then
do some ioctls to get the info you require.

or cdrecord i think has an option to dump the info.

On Mon, 2002-12-23 at 21:02, Adam Hunt wrote:
> Is there a simple way of determining if there is a disc in a CD/DVD drive?  
> Something in /proc would be nice.  Is there any other sort of information 
> availble such as what type of disc is in the drive? 
>  


