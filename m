Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263997AbRFEOlL>; Tue, 5 Jun 2001 10:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264003AbRFEOlB>; Tue, 5 Jun 2001 10:41:01 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:46087 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S263997AbRFEOks>; Tue, 5 Jun 2001 10:40:48 -0400
Date: Wed, 6 Jun 2001 02:40:44 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Vipin Malik <vipin.malik@daniel.com>
Cc: Bjorn Wesen <bjorn.wesen@axis.com>, David Woodhouse <dwmw2@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: Missing cache flush.
Message-ID: <20010606024044.A23954@metastasis.f00f.org>
In-Reply-To: <Pine.LNX.4.21.0106051105110.1078-100000@godzilla.axis.se> <3B1CEB15.FFB2EADB@daniel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B1CEB15.FFB2EADB@daniel.com>; from vipin.malik@daniel.com on Tue, Jun 05, 2001 at 09:22:13AM -0500
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2001 at 09:22:13AM -0500, Vipin Malik wrote:

    Here's a stupid question: Are there any processors out there that
    have a cache but no explicit cache-flush command?

Yes, and as Linus pointed out, some with the ability are broken
anyhow.


  --cw
