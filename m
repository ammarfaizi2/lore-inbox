Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbTBYObx>; Tue, 25 Feb 2003 09:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265246AbTBYObx>; Tue, 25 Feb 2003 09:31:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23561 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262492AbTBYObw>;
	Tue, 25 Feb 2003 09:31:52 -0500
Message-ID: <3E5B80AC.2010905@pobox.com>
Date: Tue, 25 Feb 2003 09:41:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Guggenberger 
	<Christian.Guggenberger@physik.uni-regensburg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: /proc/net/dev with tg3 and 2.4.19
References: <20030225113429.C1866@pc9391.uni-regensburg.de>
In-Reply-To: <20030225113429.C1866@pc9391.uni-regensburg.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Guggenberger wrote:
> Hi,
> 
> With tg3 from 2.4.19 the Recieve/Transmit-bytes entries grow to 4294967295, 
> but then stay at this value. This isn't the expected behaviour, is it? All 
> other net drivers will jump back to zero and count up again, won't they?
> Is there a patch available?
> Otherwise 2.4.19's tg3 seems pretty stable to me, as it's running since 2002 
> Oct. 7th with no problems...


That's fixed in later versions...

