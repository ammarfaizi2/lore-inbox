Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbUFBL0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUFBL0S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 07:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUFBL0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 07:26:18 -0400
Received: from styx.suse.cz ([82.208.2.94]:13187 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261865AbUFBL0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 07:26:17 -0400
Date: Wed, 2 Jun 2004 13:27:22 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "\"Alexey Dobriyan\" " <adobriyan@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Abandoned code in include/linux/
Message-ID: <20040602112722.GA7956@ucw.cz>
References: <E1BVSMH-0005JE-00.adobriyan-mail-ru@f17.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1BVSMH-0005JE-00.adobriyan-mail-ru@f17.mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 01:48:29PM +0400, "Alexey Dobriyan"  wrote:
> Grepping in 2.6.7-rc2 shows that nobody #include's several files
> 
> include/linux/adb_mouse.h

Not needed since ADB mice are were rewritten to use input core.

> Should something from this list stay in kernel?
> 
> Alexey
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
