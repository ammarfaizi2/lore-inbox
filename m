Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbTEFLAE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 07:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTEFLAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 07:00:04 -0400
Received: from holomorphy.com ([66.224.33.161]:19335 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262531AbTEFLAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 07:00:03 -0400
Date: Tue, 6 May 2003 04:11:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.68] Scalability issues
Message-ID: <20030506111159.GR8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Felix von Leitner <felix-kernel@fefe.de>,
	linux-kernel@vger.kernel.org
References: <20030504173956.GA28370@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030504173956.GA28370@codeblau.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 04, 2003 at 07:39:56PM +0200, Felix von Leitner wrote:
>   Out of Memory: Killed process 51 (sshd).
>   artillery-fork: page allocation failure. order:0, mode:0x20
>     [this message comes about 50 times]
>   Out of Memory: Killed process 52 (zsh).
>   spurious 8259A interrupt: IRQ7.
>   Out of Memory: Killed process 49 (sshd).
>   alloc_area_pte: page already exists
>   alloc_area_pte: page already exists
>   alloc_area_pte: page already exists
>   alloc_area_pte: page already exists
>   VFS: Close: file count is 0
>   VFS: Close: file count is 0

Could I get a list of devices on your system and the drivers you're using?
A .config and a list of out-of-tree modules (ignore nvidia you already
reproduced without it) would be nice, too.

Thanks.

-- wli
