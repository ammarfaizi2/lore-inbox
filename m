Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129172AbRAYUIl>; Thu, 25 Jan 2001 15:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135636AbRAYUIb>; Thu, 25 Jan 2001 15:08:31 -0500
Received: from hermes.mixx.net ([212.84.196.2]:35858 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129172AbRAYUIO>;
	Thu, 25 Jan 2001 15:08:14 -0500
Message-ID: <3A708722.C21EC12A@innominate.de>
Date: Thu, 25 Jan 2001 21:05:54 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: inode->i_dirty_buffers redundant ?
In-Reply-To: <200101251047.QAA16434@vxindia.veritas.com> <20010125164432.A12984@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" wrote:
> We also maintain the 
> per-page buffer lists as caches of the virtual-to-physical mapping to
> avoid redundant bmap()ping.

Could you clarify that one, please?

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
