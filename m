Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276280AbRJCNlI>; Wed, 3 Oct 2001 09:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276282AbRJCNk7>; Wed, 3 Oct 2001 09:40:59 -0400
Received: from i212.netz.at ([194.152.163.212]:21770 "EHLO pixelwings.com")
	by vger.kernel.org with ESMTP id <S276280AbRJCNkz>;
	Wed, 3 Oct 2001 09:40:55 -0400
Date: Wed, 03 Oct 2001 15:41:25 +0200
From: Clemens Schwaighofer <cs@pixelwings.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [POT] Which journalised filesystem ?  (fwd)
Message-ID: <706340000.1002116485@gullevek.piwi.intern>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



---------- Forwarded Message ----------
Date: Wednesday, October 03, 2001 03:38:55 PM +0200
From: Clemens Schwaighofer <cs@pixelwings.com>
To: Dave Jones <davej@suse.de>
Subject: Re: [POT] Which journalised filesystem ?

Hello Dave Jones

--On Wednesday, October 03, 2001 02:54:17 PM +0200 you wrote:

> Alan mentioned this was something to do with the IBM hard disk
> having strange write-cache properties that confuse ext3.
> I'm not sure if this has been fixed or not yet, but its enough
> to make me think twice about trying it on the vaio for a while.

I used it succesfully on a VAIO notebook (2.4.10 + ext3) and I had no
troubles. But I had that notebook only for a week, so I couldn't do any
extensible tests, the only thing I did, was cutting the power and seeing if
it recovers. and it did. fast and without problems.

but to the point of that thread. we had reiser FS on a production server
(Fileserver for NFS, Samba & Appletalk) and we nothing but troubles. It was
an 2.2.16 kernel and i dunno witch reiserfs we used. But from this point
forward I dun think I will use it again soon on a production server.

--
"Freiheit ist immer auch die Freiheit des Andersdenkenden"
Rosa Luxemburg, 1871 - 1919
mfg, Clemens Schwaighofer              PIXELWINGS Medien AG
Kandlgasse 15/5, A-1070 Wien           T: [+43 1] 524 58 50
JETZT NEU! MIT FEWA GEWASCHEN --> http://www.pixelwings.com

---------- End Forwarded Message ----------



--
"Freiheit ist immer auch die Freiheit des Andersdenkenden"
Rosa Luxemburg, 1871 - 1919
mfg, Clemens Schwaighofer              PIXELWINGS Medien AG
Kandlgasse 15/5, A-1070 Wien           T: [+43 1] 524 58 50
JETZT NEU! MIT FEWA GEWASCHEN --> http://www.pixelwings.com
