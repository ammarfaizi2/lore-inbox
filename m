Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129390AbRAZJOj>; Fri, 26 Jan 2001 04:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132562AbRAZJO3>; Fri, 26 Jan 2001 04:14:29 -0500
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:43781 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129390AbRAZJOR>; Fri, 26 Jan 2001 04:14:17 -0500
Date: Fri, 26 Jan 2001 22:14:14 +1300
From: Chris Wedgwood <cw@f00f.org>
To: CaT <cat@zip.com.au>
Cc: "David S. Miller" <davem@redhat.com>,
        "James H. Cloos Jr." <cloos@jhcloos.com>, linux-kernel@vger.kernel.org
Subject: Re: hotmail can't deal with ECN
Message-ID: <20010126221414.E11097@metastasis.f00f.org>
In-Reply-To: <14960.29127.172573.22453@pizda.ninka.net> <200101251905.f0PJ5ZG216578@saturn.cs.uml.edu> <14960.31423.938042.486045@pizda.ninka.net> <20010125115214.D9992@draco.foogod.com> <m3itn3i5iu.fsf@austin.jhcloos.com> <14960.50897.494908.316057@pizda.ninka.net> <20010126115057.A366@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010126115057.A366@zip.com.au>; from cat@zip.com.au on Fri, Jan 26, 2001 at 11:50:57AM +1100
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2001 at 11:50:57AM +1100, CaT wrote:

    *screatches head*
    
    I'm not sure as to what the problem with hotmail may be. I have ECN
    turned on:
    
    gozer:~# more /proc/sys/net/ipv4/tcp_ecn 
    1
    
    and I can contact hotmail just fine. I also can ftp to your site
    non-passively. where should I go to on hotmail to see it fail?

Your ISP probably transparently proxies/caches your http sessions...


  --cw

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
