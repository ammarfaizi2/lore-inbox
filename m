Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268162AbTBSJi2>; Wed, 19 Feb 2003 04:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268165AbTBSJi2>; Wed, 19 Feb 2003 04:38:28 -0500
Received: from holomorphy.com ([66.224.33.161]:59288 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268162AbTBSJi1>;
	Wed, 19 Feb 2003 04:38:27 -0500
Date: Wed, 19 Feb 2003 01:47:30 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Meino Christian Cramer <mccramer@s.netic.de>
Cc: efraim@clues.de, linux-kernel@vger.kernel.org
Subject: Re: 2.5.62 fails to boot, Uncompressing... and then nothing
Message-ID: <20030219094730.GS29983@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Meino Christian Cramer <mccramer@s.netic.de>, efraim@clues.de,
	linux-kernel@vger.kernel.org
References: <20030219071932.GA3746@clues.de> <20030219073221.GR29983@holomorphy.com> <20030219.095905.92587466.mccramer@s.netic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030219.095905.92587466.mccramer@s.netic.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2003 at 09:59:05AM +0100, Meino Christian Cramer wrote:
>  I have the sam eproblem here, but ACPI is definetly not configured...
>  Any idea else ?
>  Thank you for any help in advance ! :O)

Try plopping down any of the more recent early_printk() patches and
posting some bootlogs, then.


-- wli
