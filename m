Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265608AbUA0Anb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 19:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265611AbUA0Anb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 19:43:31 -0500
Received: from greendale.ukc.ac.uk ([129.12.21.13]:9667 "EHLO
	greendale.ukc.ac.uk") by vger.kernel.org with ESMTP id S265608AbUA0Ana
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 19:43:30 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Encrypted Filesystem
References: <OFA97B290B.67DE842E-ON87256E27.0061728C-86256E27.0061BB0E@us.ibm.com>
From: Adam Sampson <azz@us-lot.org>
Organization: Things I did not know at first I learned by doing twice.
Date: Tue, 27 Jan 2004 00:43:21 +0000
In-Reply-To: <OFA97B290B.67DE842E-ON87256E27.0061728C-86256E27.0061BB0E@us.ibm.com> (Michael
 A. Halcrow's message of "Mon, 26 Jan 2004 11:46:29 -0600")
Message-ID: <y2ar7xmkyqe.fsf@cartman.at.fivegeeks.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-UKC-Mail-System: No virus detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael A Halcrow <mahalcro@us.ibm.com> writes:

>  - Userland filesystem-based (EncFS+FUSE, CryptoFS+LUFS)

Going off on a tangent...

There are all sorts of potentially-interesting things that could be
done if Linux had a userspace filesystem mechanism included in the
standard kernel -- as well as encryption, there's also network
filesystems, various sorts of specialised caching (such as Zero
Install), automounter-like systems, prototyping and so on.

Is there a technical reason that none of the userspace filesystem
layers have been included in the stock kernel, or is it just that
nobody's submitted any of them for inclusion yet?

-- 
Adam Sampson <azz@us-lot.org>                        <http://offog.org/>
