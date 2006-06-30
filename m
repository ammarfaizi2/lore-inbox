Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWF3Kju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWF3Kju (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 06:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWF3Kju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 06:39:50 -0400
Received: from ns.suse.de ([195.135.220.2]:9150 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932403AbWF3Kju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 06:39:50 -0400
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Proposal and plan for ext2/3 future development work
References: <E1Fvjsh-0008Uw-85@candygram.thunk.org>
From: Andi Kleen <ak@suse.de>
Date: 30 Jun 2006 12:39:48 +0200
In-Reply-To: <E1Fvjsh-0008Uw-85@candygram.thunk.org>
Message-ID: <p73sllnvsej.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:
> 
> 1) The creation of a new filesystem codebase in the 2.6 kernel tree in
> /usr/src/linux/fs/ext4 that will initially register itself as the
> "ext3dev" 

Why not call it ext4 from the beginning too? Calling the directory
differently from the file system can only cause confusion.

I assume if it's marked very experimental people who value their data
will avoid it for the time being.

-Andi
