Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129819AbQKILN6>; Thu, 9 Nov 2000 06:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130133AbQKILNs>; Thu, 9 Nov 2000 06:13:48 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:21258 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129819AbQKILNf>; Thu, 9 Nov 2000 06:13:35 -0500
Date: Thu, 9 Nov 2000 12:13:21 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Michele Iacobellis <miacobellis@linuximpresa.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: No tcp connection establishment with 2.4
Message-ID: <20001109121321.P20883@arthur.ubicom.tudelft.nl>
In-Reply-To: <20001109110354.872F0186@linuximpresa.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001109110354.872F0186@linuximpresa.it>; from miacobellis@linuximpresa.it on Thu, Nov 09, 2000 at 12:08:32PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
X-Loop: erik@arthur.ubicom.tudelft.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2000 at 12:08:32PM +0100, Michele Iacobellis wrote:
> [Summary]
> No tcp connection establishment with 2.4
> 

[snip]

Disable "Explicit congestion notification support" in the networking
options. It breaks with certain Cisco firewalls.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
