Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268744AbUHLU35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268744AbUHLU35 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 16:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268747AbUHLU34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 16:29:56 -0400
Received: from mail.tmr.com ([216.238.38.203]:14354 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S268744AbUHLU3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 16:29:34 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: BitTorrent and iptables (was: Can not read UDF CD)
Date: Thu, 12 Aug 2004 16:33:16 -0400
Organization: TMR Associates, Inc
Message-ID: <cfgjk6$gbi$1@gatekeeper.tmr.com>
References: <B1ECE240295BB146BAF3A94E00F2DBFF090213@piramida.hermes.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1092342214 16754 192.168.12.100 (12 Aug 2004 20:23:34 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <B1ECE240295BB146BAF3A94E00F2DBFF090213@piramida.hermes.si>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Balazic wrote:
> OK, I put the ISO image and the udf checker outputs on BitTorrent,
> the torrent file is avaliable at
> http://lizika.pfmb.uni-mb.si/~stein/UDF_image_and_reports.torrent
> 
> In case you don't have a BitTorrent client, one can be had at
> http://bitconjurer.org/BitTorrent/download.html
> ( even a commandline version , written in python )

I used torrent to pull something the other day, and while I could pull, 
no one could connect to get data from me. I have my iptables set to 
ESTABLISHED,RELATED so iptables may not know about torrent.

Just a thought, since you have set up this way.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
