Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269564AbUICSFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269564AbUICSFK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 14:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269709AbUICSDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 14:03:48 -0400
Received: from holomorphy.com ([207.189.100.168]:24454 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269701AbUICSCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 14:02:07 -0400
Date: Fri, 3 Sep 2004 11:02:00 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm3
Message-ID: <20040903180200.GS3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paulo Marques <pmarques@grupopie.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040903014811.6247d47d.akpm@osdl.org> <20040903172354.GR3106@holomorphy.com> <4138AF0C.4010703@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4138AF0C.4010703@grupopie.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 06:51:08PM +0100, Paulo Marques wrote:
> Could you send me the .tmp_kallsyms2.S and System.map files from
> this kernel build, please, please, please?
> I really want to address this problem, but without hardware and
> without more information I'm a little in the dark (although
> looking at the resulting names already gives some clues).
> Also, doing a "cat /proc/kallsyms" shows the same kind of behavior,
> doesn't it? (just to be sure)

cat /proc/kallsyms also exhibits this problem.

The data will appear shortly at:

ftp://ftp.kernel.org/pub/linux/kernel/people/wli/misc/kallsyms2.S-sparc64.gz
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/misc/System.map-2.6.9-rc1-mm3-sparc64.gz


-- wli
