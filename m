Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319432AbSILEsM>; Thu, 12 Sep 2002 00:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319433AbSILEsM>; Thu, 12 Sep 2002 00:48:12 -0400
Received: from angband.namesys.com ([212.16.7.85]:18050 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S319432AbSILEsL>; Thu, 12 Sep 2002 00:48:11 -0400
Date: Thu, 12 Sep 2002 08:53:00 +0400
From: Oleg Drokin <green@namesys.com>
To: Dieter N?tzel <Dieter.Nuetzel@hamburg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] [BK] ReiserFS file write bug fix for 2.4
Message-ID: <20020912085300.A4625@namesys.com>
References: <3D7F7783.6030804@namesys.com> <200209111934.11373.Dieter.Nuetzel@hamburg.de> <20020911215310.A1504@namesys.com> <200209112137.22422.Dieter.Nuetzel@hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200209112137.22422.Dieter.Nuetzel@hamburg.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Sep 11, 2002 at 09:37:22PM +0200, Dieter N?tzel wrote:
> > On Wed, Sep 11, 2002 at 07:34:11PM +0200, Dieter N?tzel wrote:
> > > On Wednesday 11 September 2002 19:04, Hans Reiser wrote:
> > > > Well, at least getting the new file write code into pre6 found this bug
> > > > for us....  please apply.
> > > What is the "right" way to get the new block allocation going?
> > use 2.4.19-pre2+ and it is in there ;)
> You meant 2.4.20-pre2, didn't you?

Ah, yes. 2.4.20-pre2+ of course.

Bye,
    Oleg
