Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135240AbRAZNJe>; Fri, 26 Jan 2001 08:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135803AbRAZNJZ>; Fri, 26 Jan 2001 08:09:25 -0500
Received: from [63.95.87.168] ([63.95.87.168]:60430 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S135240AbRAZNJL>;
	Fri, 26 Jan 2001 08:09:11 -0500
Date: Fri, 26 Jan 2001 08:09:09 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: Chris Wedgwood <cw@f00f.org>
Cc: CaT <cat@zip.com.au>, "David S. Miller" <davem@redhat.com>,
        "James H. Cloos Jr." <cloos@jhcloos.com>, linux-kernel@vger.kernel.org
Subject: Re: hotmail can't deal with ECN
Message-ID: <20010126080909.A5277@xi.linuxpower.cx>
In-Reply-To: <14960.29127.172573.22453@pizda.ninka.net> <200101251905.f0PJ5ZG216578@saturn.cs.uml.edu> <14960.31423.938042.486045@pizda.ninka.net> <20010125115214.D9992@draco.foogod.com> <m3itn3i5iu.fsf@austin.jhcloos.com> <14960.50897.494908.316057@pizda.ninka.net> <20010126115057.A366@zip.com.au> <20010126221414.E11097@metastasis.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <20010126221414.E11097@metastasis.f00f.org>; from cw@f00f.org on Fri, Jan 26, 2001 at 10:14:14PM +1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2001 at 10:14:14PM +1300, Chris Wedgwood wrote:
> On Fri, Jan 26, 2001 at 11:50:57AM +1100, CaT wrote:
>>     *screatches head*
>>     
>>     I'm not sure as to what the problem with hotmail may be. I have ECN
>>     turned on:
>>     
>>     gozer:~# more /proc/sys/net/ipv4/tcp_ecn 
>>     1
>>     
>>     and I can contact hotmail just fine. I also can ftp to your site
>>     non-passively. where should I go to on hotmail to see it fail?
> 
> Your ISP probably transparently proxies/caches your http sessions...

Anyone know the person at AOL responcible for their proxy?
I bet I know a way to get ECN fixed once and for all. (It's not like AOL
would lose users over it... Their tech support is already very skilled at
telling people it's the remote site's fault. :)  ).
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
