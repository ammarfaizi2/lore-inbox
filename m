Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261921AbRESRu4>; Sat, 19 May 2001 13:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261914AbRESRuq>; Sat, 19 May 2001 13:50:46 -0400
Received: from vitelus.com ([64.81.36.147]:29189 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S261919AbRESRuc>;
	Sat, 19 May 2001 13:50:32 -0400
Date: Sat, 19 May 2001 10:50:06 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Andries.Brouwer@cwi.nl
Cc: andrewm@uow.edu.au, viro@math.psu.edu, bcrl@redhat.com, clausen@gnu.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code inuserspace
Message-ID: <20010519105006.B2648@vitelus.com>
In-Reply-To: <UTC200105191130.NAA53601.aeb@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <UTC200105191130.NAA53601.aeb@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Sat, May 19, 2001 at 01:30:14PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2001 at 01:30:14PM +0200, Andries.Brouwer@cwi.nl wrote:
> I don't think so. It is necessary, and it is good.
> 
> But it is easy to make the transition painless.
> Instead of the current choice between INITRD (yes/no)
> we have INITRD (default built-in / external).
> The built-in version can then slowly become smaller and die.

initrd is an unnecessary pain in the ass for most people. It had
better not become mandatory.
