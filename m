Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267955AbUHKGGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267955AbUHKGGg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 02:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267957AbUHKGGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 02:06:36 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:59884
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S267955AbUHKGGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 02:06:34 -0400
Message-ID: <4119B768.6030807@bio.ifi.lmu.de>
Date: Wed, 11 Aug 2004 08:06:32 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: knobi@knobisoft.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: OT: Distribution for Power4 Machines
References: <20040811055622.52917.qmail@web13911.mail.yahoo.com>
In-Reply-To: <20040811055622.52917.qmail@web13911.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Knoblauch wrote:
> Hi,
> 
>  sorry for the most likely off-topic post. Are there any distributions
> out there that support IBM Power4 systems (pSeries machines)?

SuSEs SLES8 is out for long, SLES9 for pSeries will be this month I guess.
RedHat has a version for pSeries too.
We are running SLES8 currently and it works fine except for a scsi bug
with the imbsis controller caused by the 2.4 kernel, that is fixed in
the 2.6 kernel. You will have terrible disk performance in certain
situations with 2.4. So it might be worth waiting for SLES9.

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

