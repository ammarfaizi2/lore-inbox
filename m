Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbTJAJCb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 05:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbTJAJCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 05:02:31 -0400
Received: from serena.fsr.ku.dk ([130.225.215.194]:33921 "EHLO
	serena.fsr.ku.dk") by vger.kernel.org with ESMTP id S261332AbTJAJCa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 05:02:30 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Radeon framebuffer problems i 2.6.0-test6
References: <7gisna11e1.fsf@serena.fsr.ku.dk>
	<16250.4701.976132.141380@wombat.chubb.wattle.id.au>
From: Henrik Christian Grove <grove@sslug.dk>
Organization: =?iso-8859-1?q?Sk=E5ne_Sj=E6lland?= Linux User Group
Date: 01 Oct 2003 11:02:29 +0200
In-Reply-To: <16250.4701.976132.141380@wombat.chubb.wattle.id.au>
Message-ID: <7gwubpz5y2.fsf@serena.fsr.ku.dk>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb <peter@chubb.wattle.id.au> writes:

> Try this patch that's been floating around for a while.

That solved the problem for me.
 
> Ani, can you please push this patch to Linus?

Please do that.

.Henrik

-- 
"Done. For future reference - don't anybody else try to send patches as
vi scripts, please. Yes, it's manly, but let's face it, so is
bungee-jumping with the cord tied to your testicles."
						       -- Linus Torvalds
