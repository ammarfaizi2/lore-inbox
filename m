Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWCBMq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWCBMq1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 07:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWCBMq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 07:46:27 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:53212 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751390AbWCBMq1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 07:46:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kZBpn7eIA7m+F7/8Ma8ugMnTWSGbl4qn2OflxehaPGOCWKW13nT5NjomHWV86m2UzNInG05//6HwtEUw3OfaumcJ34aFQXzWTrXGAY9HborUwCyKY15EbaKr4+StoPqWW4Q5p02onnA2sIBBDmKEJxNsAci19T/GWt7v0MpNZHo=
Message-ID: <42c5b570603020446g1a1884c8ga3a2c9f70083243e@mail.gmail.com>
Date: Thu, 2 Mar 2006 18:16:24 +0530
From: "Prosenjit Kundu" <pkundu.kernel@gmail.com>
To: "Arijit Das" <Arijit.Das@synopsys.com>
Subject: Re: Getting CPU Usage of a running child process
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7EC22963812B4F40AE780CF2F140AFE9596587@IN01WEMBX1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7EC22963812B4F40AE780CF2F140AFE9596587@IN01WEMBX1.internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

try to get the info from "top"

PK

On 3/2/06, Arijit Das <Arijit.Das@synopsys.com> wrote:
> The times() function gets me the system/user CPU usage of me (invoking
> process) and all my terminated/waited children.
>
> Is there any User Space API/way for me (a process) to get the
> system/user CPU usage of one of my currently running child process? Am
> looking for a portable solution...not sure if there is any
>
> Thanks,
> Arijit
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


--
Regards,
Prosenjit Kundu
