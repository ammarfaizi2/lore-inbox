Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317586AbSGOSjM>; Mon, 15 Jul 2002 14:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317589AbSGOSjL>; Mon, 15 Jul 2002 14:39:11 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:20255 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S317586AbSGOSjI> convert rfc822-to-8bit; Mon, 15 Jul 2002 14:39:08 -0400
Date: Mon, 15 Jul 2002 12:41:57 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Dagfinn Ilmari =?iso-8859-1?q?Manns=E5ker?= <ilmari@ping.uio.no>
cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Killing/removing defunct processes?
In-Reply-To: <d8jadotqftg.fsf@wirth.ping.uio.no>
Message-ID: <Pine.LNX.4.44.0207151241350.3452-100000@hawkeye.luckynet.adm>
X-Location: Canberra; Australia
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15 Jul 2002, Dagfinn Ilmari Mannsåker wrote:
> You want both these options when mounting. It might be possible to do a
> "mount -o remount,intr /hung/nfs/mount" and then kill, but I'm not sure.

This should only make mount hang in D state, too.

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

