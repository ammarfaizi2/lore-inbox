Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267743AbUBSCuk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 21:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267740AbUBSCuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 21:50:40 -0500
Received: from main.gmane.org ([80.91.224.249]:57825 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267712AbUBSCug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 21:50:36 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?Leandro_Guimar=E3es_Faria_Corsetti_Dutra?= 
	<leandro@dutra.fastmail.fm>
Subject: Re: ext3 on raid5 failure
Date: Wed, 18 Feb 2004 23:32:37 -0300
Organization: =?ISO-8859-1?Q?=20Fam=C3=ADlia?= Dutra
Message-ID: <pan.2004.02.19.02.32.37.90698@dutra.fastmail.fm>
References: <400A5FAA.5030504@portrix.net> <20040118180232.GD1748@srv-lnx2600.matchmail.com> <20040119153005.GA9261@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 200-138-088-244.mganm7001.dsl.brasiltelecom.net.br
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jan 2004 10:30:05 -0500, Theodore Ts'o wrote:

>> On Sun, Jan 18, 2004 at 11:27:54AM +0100, Jan Dittmer wrote:
>> > EXT3-fs error (device dm-1): ext3_readdir: bad entry in directory
>> > #9783034: rec_len % 4 != 0 - offset=0, inode=1846971784,
>> > rec_len=33046, name_len=154
>> > Aborting journal on device dm-1.
>> > ext3_abort called.
>> > EXT3-fs abort (device dm-1): ext3_journal_start: Detected aborted
>> > journal Remounting filesystem read-only

	Has this been resolved?  I have a machine due to enter production, am
considering going back to 2.4 if there is no further information.


-- 
Leandro Guimarães Faria Corsetti Dutra           +55 (11) 5685 2219
Av Sgto Geraldo Santana, 1100 6/71               +55 (11) 5686 9607
04.674-000  São Paulo, SP                                    BRASIL
http://br.geocities.com./lgcdutra/

