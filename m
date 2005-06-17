Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVFQNk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVFQNk6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 09:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVFQNk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 09:40:57 -0400
Received: from nproxy.gmail.com ([64.233.182.201]:29959 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261970AbVFQNky convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 09:40:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lYwSFeLgfvscnbGw9/xcg4Rw8iW5pHRoUBczobuC2hwXH3aSenQzDMzruDOz3akebrJ8i1BHg0JRF8+Qbu59+Uwb0ki3GUpyaISWm3WOPvponr5cYd6Ywvz8stP+PzjnONHGaQ2McNHTcMRDHvkIEmOhuB4FJOgALgviI2D0MFI=
Message-ID: <4ad99e05050617064058e952b6@mail.gmail.com>
Date: Fri, 17 Jun 2005 15:40:52 +0200
From: Lars Roland <lroland@gmail.com>
Reply-To: Lars Roland <lroland@gmail.com>
To: abonilla@linuxwireless.org
Subject: Re: tg3 in 2.6.12-rc6 and Cisco PIX SMTP fixup
Cc: Valdis.Kletnieks@vt.edu, Christian Kujau <evil@g-house.de>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <001f01c57341$1802c3b0$600cc60a@amer.sykes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ad99e05050617061864f286a2@mail.gmail.com>
	 <001f01c57341$1802c3b0$600cc60a@amer.sykes.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/05, Alejandro Bonilla <abonilla@linuxwireless.org> wrote:
>         So what do we really have here? Problem with Cisco or a problem in the
> driver? Both?

My bet is that this is a Cisco bug. The only fix for this that I have
found on cisco is turning smtp fixup off, even upgrading to the latest
cisco does not fix it completely.



Regards.

Lars Roland
