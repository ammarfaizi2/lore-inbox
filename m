Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276860AbRJHLX6>; Mon, 8 Oct 2001 07:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276863AbRJHLXs>; Mon, 8 Oct 2001 07:23:48 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:18962 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S276860AbRJHLXj>; Mon, 8 Oct 2001 07:23:39 -0400
Date: Mon, 8 Oct 2001 13:24:06 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Arquimedes Canedo <boig@casitadelterror.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compaq 1202, pcmcia trouble
Message-ID: <20011008132406.C30568@arthur.ubicom.tudelft.nl>
In-Reply-To: <3BC0F254.C6482C4C@casitadelterror.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BC0F254.C6482C4C@casitadelterror.com>; from boig@casitadelterror.com on Sun, Oct 07, 2001 at 07:24:52PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2001 at 07:24:52PM -0500, Arquimedes Canedo wrote:
> I bought a compaq laptop 1202, I've installed Slackware 8.0, kernel
> 2.4.5.
> 
> I bought a pcmcia realtek 8139 NIC, in windows works fine.
> 
> Donald Becker told me that this might be a pcmcia issue.
> I've tried with kernel 2.2.x and rtl8139.c and I haven't been luckly.

Known issue, you're using a TI 1410 Cardbus bridge and kernel 2.4.5.
Pleas upgrade to a more recent kernel, this was fixed in
linux-2.4.5-ac24.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
