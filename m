Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbULUK4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbULUK4j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 05:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbULUK4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 05:56:39 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:55595 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261730AbULUK4h convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 05:56:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=DHHDf0C1d++9SOJaR+UfLecKpLVXte3NLcUoWq8YxgPFXJoCE3KBkCobe9mU2qLw4pn49NGmUtSNdZIsabIQ7tWMGMn9Xj2mC6n/cK5Pbx836UBP/uV6roLO55WCGGAcnfSvupvOQIJnASv8X6YhblFmMAihGQLu9XSuZBrnADA=
Message-ID: <f396da0804122102561d30d04e@mail.gmail.com>
Date: Tue, 21 Dec 2004 12:56:36 +0200
From: Margus Eha <margus.eha@gmail.com>
Reply-To: Margus Eha <margus.eha@gmail.com>
To: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Re: Error - Kernel panic - not syncing:VFS:unable to mount root fs on unknown block (0,0)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041221103454.22841.qmail@web60603.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
References: <20041221103454.22841.qmail@web60603.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems you are missing ide.

Margus


On Tue, 21 Dec 2004 02:34:54 -0800 (PST), selvakumar nagendran
<kernelselva@yahoo.com> wrote:
>   I installed the latest stable 2.6.9 kernel in my
> system. When I rebooted the system with the kernel it
> showed the following error.
> 
>      "Kernel panic - not syncing:VFS:unable to mount
> root fs on unknown block (3,1)"
> 
>     What is the solution to get rid of this error?
>     What is the measure to prevent such errors in the
> future?
>      I downloaded the kernel source tar ball from
> kernel.org
>     Can anyone help me regarding this?
> 
> Thanks,
> selva
> 
> __________________________________
> Do you Yahoo!?
> All your favorites on one personal page – Try My Yahoo!
> http://my.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
