Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbTDHOJD (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 10:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbTDHOJD (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 10:09:03 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:11322 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S261809AbTDHOJC (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 10:09:02 -0400
Date: Tue, 8 Apr 2003 17:20:20 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] New kernel tree for embedded linux
Message-ID: <20030408142020.GS159052@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	linux-kernel@vger.kernel.org
References: <20030407171037.GB8178@wohnheim.fh-wedel.de> <20030408093329.GT23095@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030408093329.GT23095@lug-owl.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 11:33:30AM +0200, you [Jan-Benedict Glaw] wrote:
> On Mon, 2003-04-07 19:10:37 +0200, Jörn Engel <joern@wohnheim.fh-wedel.de>
> wrote in message <20030407171037.GB8178@wohnheim.fh-wedel.de>:
> > Hi!
> > 
> > Some days ago, I've started a -je [*] tree which will focus on memory
> > reduction for the linux kernel.
> 
> If you can live with being blind, substiture printk with a macro (doing
> nothing but eventually evaluating the parameters). That'll easily give
> you another 100K or even more.

There was a quite flexible solution proposed sometime ago...

http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=utf-8&threadm=20021024030143.GA13661%40eskimo.com&rnum=4&prev=/groups%3Fq%3Dprintk%2BCONFIG_TINY%26num%3D50%26hl%3Den%26lr%3D%26ie%3DUTF-8%26oe%3Dutf-8%26sa%3DN%26tab%3Dwg



-- v --

v@iki.fi
