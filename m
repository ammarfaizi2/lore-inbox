Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbTKBH2R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 02:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTKBH2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 02:28:17 -0500
Received: from azgamers.com ([68.98.208.145]:64159 "HELO azgamers.com")
	by vger.kernel.org with SMTP id S261538AbTKBH2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 02:28:16 -0500
From: "Matt H." <lkml@lpbproductions.com>
To: brian@worldcontrol.com, linux-kernel@vger.kernel.org
Subject: Re: C3 compiled 2.4.20 kernel blows up on EPIA M
Date: Sun, 2 Nov 2003 00:29:28 -0700
User-Agent: KMail/1.5.93
References: <20031102072323.GA7910@top.worldcontrol.com>
In-Reply-To: <20031102072323.GA7910@top.worldcontrol.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200311020029.29061.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you tried 2.4.22 yet ? 



On Sunday 02 November 2003 12:23 am, brian@worldcontrol.com wrote:
> I have a VIA EPIA M motherboard.
> 
> http://www.viavpsd.com/product/epia_m_spec.jsp?motherboardId=81
> 
> A 2.4.20 gentoo-sources kernel compiled with
> CONFIG_MCYRIXIII blows up during boot.  Basically just after
> hitting return on grub the screen turns to all blue 'V's and
> then the acts like someone pushed the reset button.
> 
> 386 and 586 kernels work fine.
> 
> I'm running gcc 3.2.3
> 
> 
> 
> 
> -- 
> Brian Litzinger
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
