Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135724AbRDXTR6>; Tue, 24 Apr 2001 15:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135722AbRDXTRt>; Tue, 24 Apr 2001 15:17:49 -0400
Received: from goat.cs.wisc.edu ([128.105.166.42]:27153 "EHLO goat.cs.wisc.edu")
	by vger.kernel.org with ESMTP id <S135725AbRDXTRj>;
	Tue, 24 Apr 2001 15:17:39 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: Global FPU corruption in 2.2
In-Reply-To: <E14s7gz-0002fh-00@the-village.bc.nu>
From: Victor Zandy <zandy@cs.wisc.edu>
Date: 24 Apr 2001 14:17:18 -0500
In-Reply-To: Alan Cox's message of "Tue, 24 Apr 2001 19:37:38 +0100 (BST)"
Message-ID: <cpxoftmqf9d.fsf@goat.cs.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> The preferable one for performance is certainly to backport the 2.4 changes

Is it any more substantial than changing all uses of the ptrace flags
to the new variable?
