Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286386AbSAAXqD>; Tue, 1 Jan 2002 18:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286385AbSAAXpz>; Tue, 1 Jan 2002 18:45:55 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:33739
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S286382AbSAAXpj>; Tue, 1 Jan 2002 18:45:39 -0500
Date: Tue, 1 Jan 2002 16:45:46 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Momchil Velikov <velco@fadata.bg>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] mesh: target 0 aborted
Message-ID: <20020101234546.GO28513@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <87lmfhy9kh.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lmfhy9kh.fsf@fadata.bg>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 12:45:34AM +0200, Momchil Velikov wrote:

> This patch makes mesh.c compile, by adapting it to the new
> pmac_feature API (ported from the ppc tree).
> 
> In addition it contains the fix from Thomas Capricelli for the
> infamous "mesh: target 0 aborted" error, which I've been personally
> observing since 2.1.13x.

Er, what exactly is this against?  If this is just what's in the
linuxppc_2_4 tree against current 2.4.18pre, this is either (or will be
now :)) on BenH's list of things to resend to Marcelo, or there's a
problem with it still.  If you added in another patch, please re-send
this vs the linuxppc_2_4 tree.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
