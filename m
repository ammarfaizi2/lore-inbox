Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129568AbQL2ESA>; Thu, 28 Dec 2000 23:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130856AbQL2ERv>; Thu, 28 Dec 2000 23:17:51 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:41479
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S130679AbQL2ERe>; Thu, 28 Dec 2000 23:17:34 -0500
Date: Fri, 29 Dec 2000 16:47:05 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Mike Elmore <mike@kre8tive.org>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Repeatable 2.4.0-test13-pre4 nfsd Oops rears it head again
Message-ID: <20001229164705.A17269@metastasis.f00f.org>
In-Reply-To: <20001228161126.A982@lingas.basement.bogus> <200012282159.NAA00929@pizda.ninka.net> <20001228212116.A968@lingas.basement.bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001228212116.A968@lingas.basement.bogus>; from mike@kre8tive.org on Thu, Dec 28, 2000 at 09:21:16PM -0600
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2000 at 09:21:16PM -0600, Mike Elmore wrote:

    Any idea what portion of pre4 got fixed in pre5 to
    fix this problem?  I'd just like to know so I can
    look around if it comes back.

nfs over UDP? My guess is the IP fragmentation fix Alexey posted a
couple of days ago.


  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
