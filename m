Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268572AbUHLOPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268572AbUHLOPy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 10:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268574AbUHLOPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 10:15:54 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:18117
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S268572AbUHLOPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 10:15:52 -0400
Message-ID: <411B7B96.7040306@bio.ifi.lmu.de>
Date: Thu, 12 Aug 2004 16:15:50 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Robert M. Stockmann" <stock@stokkie.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <Pine.LNX.4.44.0408121549420.12580-100000@hubble.stokkie.net>
In-Reply-To: <Pine.LNX.4.44.0408121549420.12580-100000@hubble.stokkie.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert M. Stockmann wrote:
> On Thu, 12 Aug 2004, Frank Steiner wrote:

> I posted this on comp.os.linux.advocacy some time ago :
> 
> "SuSE 9.1 : i'm not impressed, its a drama"
> http://groups.google.com/groups?as_umsgid=pan.2004.07.03.05.05.30.79714@stokkie.net
> 
> There's a small typo inside and that is that :
> 
> "Not only did the suse9.1 kernel 2.4.5 ..
> 
> should read
> 
> "Not only did the suse9.1 kernel 2.6.5 ..

I can't reproduce any of the problems you described there on our SuSE 9.1
hosts... Everything runs fine here,no matter if we use the command line
or xcdroast. Must be sth. special to your hardware.
Of course, the 2.6.5 kernel is already old in generel, so I guess you
should have checked a newer kernel.
And when you only use the command line anyway, I guess you checked the
dvd+rw-tools that SuSE ships with 9.1 before being "bitterly disappointed
at SuSE 9.1" :-) Note that you need the version from their update directory
to run with subfs, but this versions indeed runs fine.

cu,
Frank
-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

