Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267094AbSIRPoK>; Wed, 18 Sep 2002 11:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267095AbSIRPoK>; Wed, 18 Sep 2002 11:44:10 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:12554 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267094AbSIRPoJ>;
	Wed, 18 Sep 2002 11:44:09 -0400
Date: Wed, 18 Sep 2002 17:47:55 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Rob Ransbottom <rir@attbi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Clumsey make, README
Message-ID: <20020918174755.B1386@mars.ravnborg.org>
Mail-Followup-To: Rob Ransbottom <rir@attbi.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.3.96.1020918101954.20879A-100000@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.96.1020918101954.20879A-100000@localhost>; from rir@attbi.com on Wed, Sep 18, 2002 at 10:22:47AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 10:22:47AM -0400, Rob Ransbottom wrote:
> So I am asking if a:
> 
> make all_modules
You can do:
make allmodconfig
make

> If such exists it should be mentioned in the README.
Try
make help

Only kernel 2.5..

	Sam
