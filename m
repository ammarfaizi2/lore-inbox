Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129299AbRBUJXc>; Wed, 21 Feb 2001 04:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129404AbRBUJXW>; Wed, 21 Feb 2001 04:23:22 -0500
Received: from [195.193.201.73] ([195.193.201.73]:5646 "EHLO
	mondriaan.macroscoop.nl") by vger.kernel.org with ESMTP
	id <S129299AbRBUJXG> convert rfc822-to-8bit; Wed, 21 Feb 2001 04:23:06 -0500
From: Pim Zandbergen <P.Zandbergen@macroscoop.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: ServeRaid 4M with IBM netfinity and kernel 2.4.x
Date: Wed, 21 Feb 2001 10:23:03 +0100
Organization: Macroscoop BV
Message-ID: <v3279tcehnihh0aeufpcsvof1bfphtt0jj@4ax.com>
In-Reply-To: <fa.dt0dlmv.1bjimr0@ifi.uio.no> <20010216032956.B11267@via.ecp.fr> <fa.h31knnv.1350epp@ifi.uio.no>
In-Reply-To: <fa.h31knnv.1350epp@ifi.uio.no>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2001 09:52:18 GMT, in fa.linux.kernel, Alan Cox wrote:

>I don't believe IBM have provided an 'official' 2.4 patch set for the serveraid
>yet so there may be bugs lurking.

They have, but they keep it pretty well hidden. Version 4.50 of the
ServeRAID driver seems to support kernel 2.4 and can be downloaded
from ftp://ftp.pc.ibm.com/pub/pccbbs/pc_servers/24p2809.tgz

There is also driver disk that lets you install Red Hat 7.0 on a
ServeRAID array which can be found at
ftp://ftp.pc.ibm.com/pub/pccbbs/pc_servers/24p2811.exe
This too was hard to find on the IBM web sites, and there is no
mention of it at all on the Red Hat web site.

While you're at it, you might just as well download
ftp://ftp.pc.ibm.com/pub/pccbbs/pc_servers/24p2817.iso and burn it on
a CD. This is a bootable (windows) CD that contains the above files
plus everything else  you need to get your ServeRAID running with
Linux or other operating systems.
