Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWHYNIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWHYNIx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 09:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWHYNIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 09:08:53 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:50813 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750944AbWHYNIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 09:08:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hk2NSiOaRPAdDfDcaimvNAqsG8yzZ/GSbi1TIL0Cugu2s0C793v+bdeepSAmmi2MQn2dAKysqyyjTtGPnbzvGhmX5NcVCOrppotBgqaERr4ikwN6SbVElQ136TC5RhAfb70zgZoDKMnej2kHSH6ifPaweav0r0deAjSfSSr2RxE=
Message-ID: <dca824fc0608250608s3b371291qd313986cffc1e028@mail.gmail.com>
Date: Fri, 25 Aug 2006 15:08:51 +0200
From: "Jan Bernatik" <jan.bernatik@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: platform device / driver question
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, I am newbie to linux kernel development, but I couldn't get my
question answered on #kernelnewbies, and I am not able to get it right
from code.

I studied smc91x driver to understand how platform driver / device
subsystem works. On #kernelnewbies channel I was told this driver is
"hopelessly broken". How should one create and register the
platform_device/driver ? Is the implementation in smc91x correct ?

If someone could clarify this, I will appreciate that, and certainly
write some newbie-understandable documentation. It is not covered by
LDD AFAIK.

thanks, have a nice day
please CC me, I am not on the list

J.
