Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129259AbQKVAfz>; Tue, 21 Nov 2000 19:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130109AbQKVAff>; Tue, 21 Nov 2000 19:35:35 -0500
Received: from lahmed.Stanford.EDU ([171.65.76.205]:48535 "EHLO
	lahmed.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S129259AbQKVAf1>; Tue, 21 Nov 2000 19:35:27 -0500
From: David Hinds <dhinds@lahmed.stanford.edu>
Date: Tue, 21 Nov 2000 16:04:44 -0800
To: Tobias Ringstrom <tori@tellus.mine.nu>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why not PCMCIA built-in and yenta/i82365 as modules
Message-ID: <20001121160443.B18150@lahmed.stanford.edu>
In-Reply-To: <Pine.LNX.4.21.0011212328570.30344-100000@svea.tellus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.21.0011212328570.30344-100000@svea.tellus>; from tori@tellus.mine.nu on Tue, Nov 21, 2000 at 11:34:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2000 at 11:34:45PM +0100, Tobias Ringstrom wrote:
> The subject says it all. Is there any particular (technical) reason why I
> must have both the generic pcmcia code and the controller support
> built-in, or build all of them as modules?

Is there a technical reason for this?  Not that I know of; but then I
also cannot think of a good reason for wanting, say, the generic code
built in but the controller support as modules.  I do see reasonable
arguments for all-builtin or all-modules.

-- Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
