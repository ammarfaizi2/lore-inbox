Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313743AbSHRK0P>; Sun, 18 Aug 2002 06:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSHRK0P>; Sun, 18 Aug 2002 06:26:15 -0400
Received: from go-gw.beelinegprs.net ([217.118.66.254]:5969 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S313743AbSHRK0O>; Sun, 18 Aug 2002 06:26:14 -0400
Date: Sat, 17 Aug 2002 18:55:27 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "H. J. Lu" <hjl@lucon.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, dhinds <dhinds@sonic.net>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: New fix for CardBus bridge behind a PCI bridge
Message-ID: <20020817185527.A595@localhost.park.msu.ru>
References: <20020810222355.A13749@lucon.org> <20020812104902.A18430@lucon.org> <20020812110431.A14125@sonic.net> <20020812112911.A18947@lucon.org> <20020812122158.A27172@sonic.net> <20020812140730.A21710@lucon.org> <20020812154851.A20073@sonic.net> <20020812202942.A27362@lucon.org> <20020816194825.A7086@jurassic.park.msu.ru> <20020816224950.A17930@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020816224950.A17930@lucon.org>; from hjl@lucon.org on Fri, Aug 16, 2002 at 10:49:50PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2002 at 10:49:50PM -0700, H. J. Lu wrote:
> CardBus works now. But I can no longer load usb-uhci. My X server no
> longer works. Your patch is not right.

More info, please (probably off-list). Kernel and X error messages, and
'lspci -vvxxx' output from your machine.
Those "transparent" bridges cause too much problems, and I'm just trying
to find a generic solution...

Ivan.
