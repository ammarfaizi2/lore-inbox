Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292963AbSBVTjn>; Fri, 22 Feb 2002 14:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292967AbSBVTjg>; Fri, 22 Feb 2002 14:39:36 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:56900 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S292963AbSBVTjV>; Fri, 22 Feb 2002 14:39:21 -0500
Date: Fri, 22 Feb 2002 20:39:02 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: 64GB (i386) kernel config + PAGE_OFFSET change
Message-ID: <20020222203902.K5004@dualathlon.random>
In-Reply-To: <200202221809.g1MI9n109591@eng2.beaverton.ibm.com> <Pine.LNX.4.21.0202221857540.1856-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0202221857540.1856-100000@localhost.localdomain>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 07:20:57PM +0000, Hugh Dickins wrote:
> if necessary, but so far nobody has wanted it enough to make the change.

exactly, and if somebody wants to make that change only make sure to
left it inside some #ifdef, so we don't slowdown the 3G standard option.

Andrea
