Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130012AbRBJNCS>; Sat, 10 Feb 2001 08:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130918AbRBJNCI>; Sat, 10 Feb 2001 08:02:08 -0500
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:65285 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S130012AbRBJNCD>; Sat, 10 Feb 2001 08:02:03 -0500
Date: Sun, 11 Feb 2001 02:02:00 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Daniel Stone <daniel@kabuki.eyep.net>
Cc: Chris Mason <mason@suse.com>, David Rees <dbr@spoke.nols.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
Message-ID: <20010211020200.A9570@metastasis.f00f.org>
In-Reply-To: <479040000.981564496@tiny> <E14QkfM-0004EL-00@piro.kabuki.eyep.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14QkfM-0004EL-00@piro.kabuki.eyep.net>; from daniel@kabuki.eyep.net on Thu, Feb 08, 2001 at 05:34:44PM +1100
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2001 at 05:34:44PM +1100, Daniel Stone wrote:

    I run Reiser on all but /boot, and it seems to enjoy corrupting my
    mbox'es randomly.

what kind of corruption are you seeing?

    This also occurs in some log files, but I put it down to syslogd
    crashing or something.

syslogd crashing shouldn't corrupt files... 



  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
