Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272121AbRIEMK7>; Wed, 5 Sep 2001 08:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272124AbRIEMKt>; Wed, 5 Sep 2001 08:10:49 -0400
Received: from mustard.heime.net ([194.234.65.222]:24448 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S272121AbRIEMKi> convert rfc822-to-8bit; Wed, 5 Sep 2001 08:10:38 -0400
Date: Wed, 5 Sep 2001 14:10:48 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Flavio Bruno Leitner <flavio@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: error compiling 2.4.9 with ess solo1 support
In-Reply-To: <20010905090821.G871@conectiva.com.br>
Message-ID: <Pine.LNX.4.30.0109051410020.1280-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

found it.
doesn't help compiling with joystick support. I actually need gameport
support, and that's only available from the -ac patches.

On Wed, 5 Sep 2001, Flavio Bruno Leitner wrote:

> On Sun, Sep 02, 2001 at 02:01:40PM +0200, Roy Sigurd Karlsbakk wrote:
> > hi all
> >
> > I get the following error message when compiling (or rather linking) 2.4.9
> > with ESS Solo1 support. Anyone have a clue?
>
> Compile with joystick support too.
>
>
> --
> Flávio Bruno Leitner <flavio@conectiva.com>
> Pesquisa e Desenvolvimento http://fly.to/fbl
> Conectiva Linux http://www.conectiva.com.br/
>


