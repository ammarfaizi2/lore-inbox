Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268376AbTBSMVq>; Wed, 19 Feb 2003 07:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268379AbTBSMVq>; Wed, 19 Feb 2003 07:21:46 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:16322 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S268376AbTBSMVq>; Wed, 19 Feb 2003 07:21:46 -0500
Date: Wed, 19 Feb 2003 13:31:38 +0100
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Meino Christian Cramer <mccramer@s.netic.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.62 fails to boot, Uncompressing... and then nothing
Message-ID: <20030219123138.GQ5239@riesen-pc.gr05.synopsys.com>
Reply-To: alexander.riesen@synopsys.COM
References: <20030219073221.GR29983@holomorphy.com> <20030219.095905.92587466.mccramer@s.netic.de> <200302191052.47663.baldrick@wanadoo.fr> <20030219.131909.59461826.mccramer@s.netic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030219.131909.59461826.mccramer@s.netic.de>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meino Christian Cramer, Wed, Feb 19, 2003 13:19:09 +0100:
>  Another thing is that make menuconfig fails to write back
>  configurations as alternate files into directories owned by root
>  and set drwxr-xr-x....but it is able to write into the . directory,
>  even if it is set with drwxr-xr-x also...

is the "." also owned by root?

