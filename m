Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131525AbRALD3J>; Thu, 11 Jan 2001 22:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131551AbRALD27>; Thu, 11 Jan 2001 22:28:59 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:23050
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S131525AbRALD2o>; Thu, 11 Jan 2001 22:28:44 -0500
Date: Fri, 12 Jan 2001 16:28:40 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O_NONBLOCK, read(), select(), NFS, Ext2, etc.
Message-ID: <20010112162840.A14811@metastasis.f00f.org>
In-Reply-To: <200101120327.f0C3Rxc02512@513.holly-springs.nc.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101120327.f0C3Rxc02512@513.holly-springs.nc.us>; from rothwell@holly-springs.nc.us on Thu, Jan 11, 2001 at 09:34:08PM -0500
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2001 at 09:34:08PM -0500, Michael Rothwell wrote:

    The man pages for open, read and write say that if a file is opened
    using the O_NONBLOCK flag, then read() and write() will always return
    immediately and not block the calling process. 

the man pages are wrong


  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
