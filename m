Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136139AbRD2Txs>; Sun, 29 Apr 2001 15:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136122AbRD2Txi>; Sun, 29 Apr 2001 15:53:38 -0400
Received: from [63.95.87.168] ([63.95.87.168]:51975 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S136139AbRD2Tx1>;
	Sun, 29 Apr 2001 15:53:27 -0400
Date: Sun, 29 Apr 2001 15:53:26 -0400
From: Gregory Maxwell <greg@linuxpower.cx>
To: Duncan Gauld <duncan@gauldd.freeserve.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: question regarding cpu selection
Message-ID: <20010429155326.C17155@xi.linuxpower.cx>
In-Reply-To: <01042919075101.01335@pc-62-31-91-135-dn.blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <01042919075101.01335@pc-62-31-91-135-dn.blueyonder.co.uk>; from duncan@gauldd.freeserve.co.uk on Sun, Apr 29, 2001 at 07:07:51PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 07:07:51PM -0400, Duncan Gauld wrote:
> Hi,
> This seems a silly question but - I have an intel celeron 800mhz CPU and thus 
> it is of the Coppermine breed. But under cpu selection when configuring the 
> kernel, should I select PIII or PII/Celeron? Just wondering, since Coppermine 
> is basically a newish PIII with 128K less cache...

PIII, the differnce in the options is stuff like SSE that your PIII/Celeron
has.
