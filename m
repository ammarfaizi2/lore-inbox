Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbVK3WFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbVK3WFc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 17:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbVK3WFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 17:05:32 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:60661 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750731AbVK3WFb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 17:05:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eYSyVQNpJBBTya0CQXYG/FMwKhenDl62vxgKUXwZIRV7buSbl5PfdtVDWByYzhvt41fV2vm1Ws0L5+XeDdN7aR8FEggKfUeWZ2nKNYMuwYXA2JxF+9vHH/jCbwJ+Fp1Z8BJV3fwsVYpjjn3yYvUsgRFvROvDdeUatz9w6CgMpV0=
Message-ID: <a762e240511301405s433109b7n93e7fdcc7409bef5@mail.gmail.com>
Date: Wed, 30 Nov 2005 14:05:30 -0800
From: Keith Mannthey <kmannth@gmail.com>
To: "0602@eq.cz" <0602@eq.cz>
Subject: Re: totally random "VFS: Cannot open root device"
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org,
       Linux-ide <linux-ide@vger.kernel.org>
In-Reply-To: <438DA3FA.2010809@eq.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <438B6E05.8070009@eq.cz> <438D2C19.3030008@gmail.com>
	 <438DA3FA.2010809@eq.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/05, 0602@eq.cz <0602@eq.cz> wrote:

Best guess is driver initilization troubles. The screen shot only
dosen't really show anything besides it is broken. A full boot log
from the failed boot would be nice.  There were some recent SATA
change could you try the current 2.6.15-rc3 as well?

Thanks,
 Keith
