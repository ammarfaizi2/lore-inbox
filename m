Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310441AbSDDF7l>; Thu, 4 Apr 2002 00:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310654AbSDDF7b>; Thu, 4 Apr 2002 00:59:31 -0500
Received: from tapu.f00f.org ([66.60.186.129]:29126 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S310441AbSDDF7X>;
	Thu, 4 Apr 2002 00:59:23 -0500
Date: Wed, 3 Apr 2002 21:59:02 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Gerd Knorr <kraxel@bytesex.org>, linux-kernel@vger.kernel.org,
        Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
Message-ID: <20020404055902.GA6889@tapu.f00f.org>
In-Reply-To: <Pine.LNX.4.33.0204032327360.2006-100000@einstein.homenet> <Pine.LNX.4.44L.0204031937560.18660-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2002 at 07:39:04PM -0300, Rik van Riel wrote:

    Indeed, Veritas has contributed significantly to kernel
    development, but I can't remember ever seeing anything but
    troubled users from companies like nvidia or vmware.

Considering the fact we are much more likely to hear complaints when
things are broken and people are seeking a fix than praise otherwise,
I think this is a little unfair.  For the vast numbers of nvidia users
I don't think there are that many problems reported and I'm not
convinced the CURRENT nvidia drivers are necessarily doing anything
bad[1].


  --cw

[1] People are welcome to provide code to prove me wrong.  I use the
    nv hardware at times and it works very well, the machines don't
    suffer filesystem corruption, crashes or memory leaks.
