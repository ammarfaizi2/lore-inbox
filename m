Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbTKQNyh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 08:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263524AbTKQNyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 08:54:37 -0500
Received: from gw-gaap.adm.nw.ru ([195.19.221.35]:64270 "EHLO cit.aanet.ru")
	by vger.kernel.org with ESMTP id S263522AbTKQNyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 08:54:35 -0500
SMTP-relay-addr: 195.19.216.60 
SMTP-relay-host: stud2.aanet.ru 
Date: Mon, 17 Nov 2003 16:57:00 +0300
From: Nikita Melnikov <ku3@stud2.aanet.ru>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AGP mode on KT-400 MB (2.6.0-test9)
Message-ID: <20031117135700.GA8490@stud2.aanet.ru>
References: <20031117125407.GA8261@stud2.aanet.ru> <20031117133014.GA28386@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031117133014.GA28386@ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 02:30:14PM +0100, Vojtech Pavlik wrote:
> On Mon, Nov 17, 2003 at 03:54:07PM +0300, Nikita Melnikov wrote:
> > Hello.
> > 
> > I have Ati Rage 128 Pro, which can perfectly run in 2x mode, but agpgart
> > always puts it into 1x mode. How could I change this setting? There are no
> > options in BIOS dedicated to agp.
> > 
> > Thanks.
> 
> You can change that in XF86Config (Option "AGPMode" "2").

Thank you very much, will try this at night.

> -- 
> Vojtech Pavlik
> SuSE Labs, SuSE CR

-- 
Nikita Melnikov
