Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263735AbUH0Lme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbUH0Lme (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 07:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUH0Lme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 07:42:34 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:14034
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S263735AbUH0LmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 07:42:21 -0400
Message-ID: <412F1E1A.40905@bio.ifi.lmu.de>
Date: Fri, 27 Aug 2004 13:42:18 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: markb@wetlettuce.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1: ip auto-config accepts wrong packages
References: <412C5E80.8050603@bio.ifi.lmu.de>	<1093439062.25506.12.camel@mbpc.signal.qinetiq.com>	<412CA518.7090109@bio.ifi.lmu.de>	<1093448839.25506.57.camel@mbpc.signal.qinetiq.com>	<412DBBF0.3090107@bio.ifi.lmu.de> <20040826091722.54a0cc72.rddunlap@osdl.org>
In-Reply-To: <20040826091722.54a0cc72.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

> Maybe fixed by
> http://linux.bkbits.net:8080/linux-2.5/cset@412a4a00MfXRfzWB5kTFo9NXM1Q3hw?nav=index.html|ChangeSet@-7d
> 
> i.e., fix is already merged, I think.

Yes, that's exactly describing the problem I encountered, and indeed
fixes it :-) I have to admit that I didn't know this page yet... I will
check there first before reporting bugs in the future!

Thanks a lot!

cu,
Frank
-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

