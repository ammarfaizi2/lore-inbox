Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129050AbQKMNPW>; Mon, 13 Nov 2000 08:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129633AbQKMNPM>; Mon, 13 Nov 2000 08:15:12 -0500
Received: from james.kalifornia.com ([208.179.0.2]:27518 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S129050AbQKMNPA>; Mon, 13 Nov 2000 08:15:00 -0500
Message-ID: <3A0FE950.D410C07C@linux.com>
Date: Mon, 13 Nov 2000 05:14:56 -0800
From: David Ford <david@linux.com>
Reply-To: david+validemail@kalifornia.com
Organization: Talon Technology, Intl.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
CC: tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status/TODO page (test11-pre3)
In-Reply-To: <200011121939.eACJd9D01319@trampoline.thunk.org> <3A0F5F6D.F8B26CDF@linux.com> <20001113103231.B28963@mea-ext.zmailer.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Figures.  I'll be quick to blame esd, it does pretty much all writes blind.

-d

Matti Aarnio wrote:

> On Sun, Nov 12, 2000 at 07:26:37PM -0800, David Ford wrote:
> > tytso@mit.edu wrote:
> > > Fixed
> > >      * Incredibly slow loopback tcp bug (believed fixed about 2.3.48)
> >
> > Note; if I set up ESD to listen on a tcp port, connecting locally sounds
> > horrible.  I haven't looked to see who's fault it really is.
>
>         FTP-transfer of large file over loopback gives me about 80 MB/sec
>         speeds at 2.4.0-test8 -- nor is the ESD bad sounding.
>
>         However my Alpha has the SB support very bad sounding..
>         It sounds like spectrum reversal, in fact -- first noticed
>         when playing stereophonic MP3 with xmms, but when same file
>         was played to .WAV file at an intel box (where it sounds quite
>         ok), and that wav is play(1)ed at the alpha -- same bad sound.
>
> > -d
>
> /Matti Aarnio

-- ---NOTICE

-- fwd: fwd: fwd: type emails will be deleted automatically.
      "There is a natural aristocracy among men. The grounds of this are
      virtue and talents", Thomas Jefferson [1742-1826], 3rd US President



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
