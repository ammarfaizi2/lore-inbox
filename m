Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263280AbTJKLNb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 07:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTJKLNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 07:13:31 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:15122 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263280AbTJKLNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 07:13:30 -0400
Date: Sat, 11 Oct 2003 13:13:28 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test7 and HIDBP
Message-ID: <20031011111328.GB932@mars.ravnborg.org>
Mail-Followup-To: Norman Diamond <ndiamond@wta.att.ne.jp>,
	"Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
References: <1f8801c38f11$da95c410$5cee4ca5@DIAMONDLX60> <20031010073750.001ad559.rddunlap@osdl.org> <242001c38fdf$fb165690$5cee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <242001c38fdf$fb165690$5cee4ca5@DIAMONDLX60>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 11, 2003 at 07:10:50PM +0900, Norman Diamond wrote:
> 
> Or maybe I'm 75% blind, maybe I it really is in gconfig and I couldn't see
> it.  But no one has said that this is the case.

If there are dofferences between what is shown in xconfig and gconfig, then
there is a bug in one of the front-ends.
They use the same back-end - and what they display is based on the same
input files.

	Sam
