Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288981AbSAUAYk>; Sun, 20 Jan 2002 19:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288980AbSAUAYa>; Sun, 20 Jan 2002 19:24:30 -0500
Received: from waste.org ([209.173.204.2]:728 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S288979AbSAUAYR>;
	Sun, 20 Jan 2002 19:24:17 -0500
Date: Sun, 20 Jan 2002 18:22:39 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: John Jasen <jjasen1@umbc.edu>, Andrew Morton <akpm@zip.com.au>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        <linux-raid@vger.kernel.org>
Subject: Re: 2.4.17 RAID-1 EXT3  reliable to hang....
In-Reply-To: <20020120215728.B1112@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.44.0201201819360.14507-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jan 2002, Matti Aarnio wrote:

>   Now to have a reliable way to find where the CPUs are spinning
>   when the thing does not work...  (I have tested kdb: keyboard
>   dies at hangup -> kdb becomes non-functional...)

KDB can still be triggered with an NMI if your mobo has an NMI button
(often a small pinhole button on the back).

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

