Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286788AbSABG41>; Wed, 2 Jan 2002 01:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286735AbSABG4R>; Wed, 2 Jan 2002 01:56:17 -0500
Received: from [80.72.64.84] ([80.72.64.84]:6784 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S286789AbSABG4E>; Wed, 2 Jan 2002 01:56:04 -0500
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] mesh: target 0 aborted
In-Reply-To: <87lmfhy9kh.fsf@fadata.bg>
	<20020101234546.GO28513@cpe-24-221-152-185.az.sprintbbd.net>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <20020101234546.GO28513@cpe-24-221-152-185.az.sprintbbd.net>
Date: 02 Jan 2002 08:56:09 +0200
Message-ID: <87d70t6y2e.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Tom" == Tom Rini <trini@kernel.crashing.org> writes:

Tom> On Wed, Jan 02, 2002 at 12:45:34AM +0200, Momchil Velikov wrote:

>> This patch makes mesh.c compile, by adapting it to the new
>> pmac_feature API (ported from the ppc tree).
>> 
>> In addition it contains the fix from Thomas Capricelli for the
>> infamous "mesh: target 0 aborted" error, which I've been personally
>> observing since 2.1.13x.

Tom> Er, what exactly is this against?  If this is just what's in the
Tom> linuxppc_2_4 tree against current 2.4.18pre, this is either (or will be
Tom> now :)) on BenH's list of things to resend to Marcelo, or there's a
Tom> problem with it still.  If you added in another patch, please re-send
Tom> this vs the linuxppc_2_4 tree.

This is against 2.4.18pre1. You may resync with it.
