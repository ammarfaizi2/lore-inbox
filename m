Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130079AbRCLNLr>; Mon, 12 Mar 2001 08:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130094AbRCLNL1>; Mon, 12 Mar 2001 08:11:27 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:15098 "HELO
	burns.conectiva") by vger.kernel.org with SMTP id <S130090AbRCLNLJ>;
	Mon, 12 Mar 2001 08:11:09 -0500
Date: Mon, 12 Mar 2001 09:47:26 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: XingFei <xing.fei@fujixerox.co.jp>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux localization
In-Reply-To: <E14cHxf-000178-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0103120946220.2102-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2001, Alan Cox wrote:

> > My work will concern with the internationalization of Linux
> > So, could anybody tell me what kinds of features should be in the
> > consideration when linux be localized from english to Japanese or chinese,
> > say using 2 bytes character set.
> 
> Most of the Linux userspace libraries are set up for handling UTF8 and
> other internationalisations. Fonts are more of an issue and lack of
> application translations. Filenames are defined to be UTF8.

An appropriate mailing list for i18n would be

	linux-utf8@nl.linux.org

To subscribe to this list, send an email with the text
"subscribe linux-utf8" to

	majordomo@nl.linux.org

cheers,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

