Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVGDTpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVGDTpy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 15:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVGDTpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 15:45:54 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:19729 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261603AbVGDTof
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 15:44:35 -0400
Date: Mon, 4 Jul 2005 21:44:59 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Consistent kernel panic on 2.6.12 in sk_alloc when using vmware vmnet bridge. Works perfect on 2.6.11.x
Message-ID: <20050704194459.GA8340@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <42C98E5A.2050309@0Bits.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42C98E5A.2050309@0Bits.COM>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2005 at 11:30:34PM +0400, Mitch wrote:
> Hi,
> 
> I'm getting a 100% reproduceable panic (stack attached) when testing out 
> vmware bridged net module on 2.6.12, 2.6.12.[12]. Reverting back to 
> 2.6.11.12 (or 2.6.11) works fine.

 I believe this was fixed by and update. Download
http://platan.vc.cvut.cz/ftp/pub/vmware/vmware-any-any-update92.tar.gz


-- 
Tomasz Torcz                        To co nierealne - tutaj jest normalne.
zdzichu@irc.-nie.spam-.pl          Ziomale na ¿ycie maj± tu patenty specjalne.

