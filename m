Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266118AbTGSUjp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 16:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270535AbTGSUjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 16:39:45 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:46861 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S266118AbTGSUjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 16:39:44 -0400
Date: Sat, 19 Jul 2003 22:54:42 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Walter Harms <WHarms@bfs.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: alpha; gas & linux 2.6.0-test1
Message-ID: <20030719205442.GB12080@mars.ravnborg.org>
Mail-Followup-To: Walter Harms <WHarms@bfs.de>,
	linux-kernel@vger.kernel.org
References: <vines.sxdD+TnO4zA@SZKOM.BFS.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vines.sxdD+TnO4zA@SZKOM.BFS.DE>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 10:41:03PM +0200, Walter Harms wrote:
> 
> hi list,
> i tried to compile linux 2.6.0 unfortunaly the
> GNU assembler version 2.11.90.0.8 (alpha-redhat-linux) using BFD version 2.11.90.0.8

Support for .incbin were introduced in binutils 2.11.90.0.23 - so no
need to check for newer version with respect to this.

	Sam
