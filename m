Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132616AbRDKQJ3>; Wed, 11 Apr 2001 12:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132618AbRDKQJT>; Wed, 11 Apr 2001 12:09:19 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:43789 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S132616AbRDKQJI>;
	Wed, 11 Apr 2001 12:09:08 -0400
Date: Wed, 11 Apr 2001 18:08:56 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Daniel Phillips <phillips@nl.linux.org>
Cc: acahalan@cs.uml.edu, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Ext2 Directory Index - File Structure
Message-ID: <20010411180856.A23974@pcep-jamie.cern.ch>
In-Reply-To: <20010411130746Z92169-20971+29@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010411130746Z92169-20971+29@humbolt.nl.linux.org>; from phillips@nl.linux.org on Wed, Apr 11, 2001 at 03:07:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> ls already can't handle the directories I'm working with on a regular
> basis.  It's broken and needs to be fixed.  A merge sort using log n
> temporary files is not hard to write.

ls -U | sort

should do the trick.

-- Jamie
