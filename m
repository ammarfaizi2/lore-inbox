Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310963AbSCRONB>; Mon, 18 Mar 2002 09:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310953AbSCROMx>; Mon, 18 Mar 2002 09:12:53 -0500
Received: from mail.pixelwings.com ([194.152.163.212]:42765 "EHLO
	pixelwings.com") by vger.kernel.org with ESMTP id <S310943AbSCROMn> convert rfc822-to-8bit;
	Mon, 18 Mar 2002 09:12:43 -0500
Date: Mon, 18 Mar 2002 15:12:38 +0100
From: Clemens Schwaighofer <cs@pixelwings.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 freezes on heavy IO
Message-ID: <21050000.1016460758@lynx>
In-Reply-To: <3C95F129.7D9744B5@gmx.net>
X-Mailer: Mulberry/2.1.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Richard Ems

--On Monday, March 18, 2002 02:52:41 PM +0100 you wrote:

> Hi all!
>
> I'm seeing my system freeze on heavy IO. Only the reset button brings it
> back to life again (ALT-SysRq-b also worked once). I'm running SuSE's
> 2.4.18-30 on a Pentium III (Coppermine) with 256 MB RAM (yes, I should
> try vanilla 2.4.18, I will ...)

try ac3 patch, it worked for me and gave me a stable system

-- 
"Der Krieg ist ein Massaker von Leuten, die sich nicht kennen, zum
Nutzen von Leuten, die sich kennen, aber nicht massakrieren"
- Paul Valéry (1871-1945)
mfg, Clemens Schwaighofer                       PIXELWINGS Medien GMBH
Kandlgasse 15/5, A-1070 Wien                      T: [+43 1] 524 58 50
JETZT NEU! MIT FEWA GEWASCHEN       -->      http://www.pixelwings.com
