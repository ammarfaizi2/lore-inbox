Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272052AbTG1G0I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 02:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272379AbTG1G0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 02:26:08 -0400
Received: from guug.org ([168.234.203.30]:40419 "EHLO guug.galileo.edu")
	by vger.kernel.org with ESMTP id S272052AbTG1G0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 02:26:06 -0400
Date: Mon, 28 Jul 2003 00:36:25 -0600
To: Harald Dunkel <harri@synopsys.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.0-test2
Message-ID: <20030728063625.GE7777@guug.org>
References: <Pine.LNX.4.44.0307271003360.3401-100000@home.osdl.org> <3F242B35.8050400@Synopsys.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F242B35.8050400@Synopsys.COM>
User-Agent: Mutt/1.5.4i
From: Otto Solares <solca@guug.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 27, 2003 at 09:42:45PM +0200, Harald Dunkel wrote:
> Hi folks,
> 
> Linus Torvalds wrote:
> >Lots of small updates and fixes all over the map (diffstat shows a flat
> >profile, except for the DVB merge, the new wl3501 driver, and the new
> >sound drivers from Alan).
> >
> 
> Probably not that important, but would it be possible to make
> all files readable (chmod a+r) before creating the new kernel
> tar file? At least the files in the Documentation and the include
> directory?

better adjust `umask 0022` @ the shell.

-solca

