Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTJCOEt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 10:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbTJCOEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 10:04:49 -0400
Received: from users.linvision.com ([62.58.92.114]:64648 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S263587AbTJCOEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 10:04:48 -0400
Date: Fri, 3 Oct 2003 16:04:42 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Zhang Jian <jzhang001@hotmail.com>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, vojtech@suse.cz
Subject: Re: urgent! help, ide driver bug?
Message-ID: <20031003140442.GA3702@bitwizard.nl>
References: <LAW11-F66x33E1ioWwr00014013@hotmail.com> <Pine.LNX.4.44.0309301545310.2912-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309301545310.2912-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 10:34:41AM -0300, Marcelo Tosatti wrote:
> 
> Zhang, 
> 
> The filesystem is getting corrupted it seems. Try turning DMA off? 

> > inode=1097631760, rec_len=0, name_len=0

Did you notice that the inode number is 0x416c8810 ? Which is: "Alx\n" .

		Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
