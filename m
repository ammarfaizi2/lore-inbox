Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129759AbRA3LQX>; Tue, 30 Jan 2001 06:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129704AbRA3LQN>; Tue, 30 Jan 2001 06:16:13 -0500
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:58629 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129101AbRA3LQH>; Tue, 30 Jan 2001 06:16:07 -0500
Date: Wed, 31 Jan 2001 00:16:05 +1300
From: Chris Wedgwood <cw@f00f.org>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [UPDATE] Fresh zerocopy patch on kernel.org
Message-ID: <20010131001605.B6620@metastasis.f00f.org>
In-Reply-To: <14966.35438.429963.405587@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14966.35438.429963.405587@pizda.ninka.net>; from davem@redhat.com on Tue, Jan 30, 2001 at 01:33:34AM -0800
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2001 at 01:33:34AM -0800, David S. Miller wrote:

    2) Accept TCP flags (ACK, URG, RST, etc.) for out of window packets
       if truncating the data to the window would make that packet valid.
       (Alexey)

    3) Add SO_ACCEPTCONN, Unix standard wants it. (me)

these have been feed back for 2.4.x Linus anyhow right?


  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
