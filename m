Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316135AbSGLMlZ>; Fri, 12 Jul 2002 08:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316158AbSGLMlY>; Fri, 12 Jul 2002 08:41:24 -0400
Received: from pD9E235D3.dip.t-dialin.net ([217.226.53.211]:20611 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316135AbSGLMlY> convert rfc822-to-8bit; Fri, 12 Jul 2002 08:41:24 -0400
Date: Fri, 12 Jul 2002 06:44:04 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
cc: Kelledin <kelledin+LKML@skarpsey.dyndns.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Missing files in 2.4.19-rc1
In-Reply-To: <Pine.OSF.4.44.0207121216580.264794-100000@tao.natur.cuni.cz>
Message-ID: <Pine.LNX.4.44.0207120643190.3421-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 12 Jul 2002, [iso-8859-2] Martin MOKREJ© wrote:
> So, what to do now? ;)

Try:

make mrproper
cp ../.config .
make oldconfig

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

