Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751654AbWHMW4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbWHMW4c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 18:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbWHMW4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 18:56:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:9405 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751645AbWHMW4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 18:56:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NI2fAIp5Yj35UBPPNwtSoBHzrPx4S7nCVx7bBYmop/Rqg3WOJWdBBclGkpGb609nZjQBMEJyDTcNQ5mWo6w6jh7UnGkmWKj1l9T7CiG9uMVL2usBCPJO6RL9vFqeQWKruMtpKrUYC+bHKOAhkMnwLOIgBNoDQFU4fjhqsArZoxg=
Message-ID: <41840b750608131556t48c38ed8p3b59930b4b9f5a51@mail.gmail.com>
Date: Mon, 14 Aug 2006 01:56:30 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: [-mm patch] make drivers/hwmon/hdaps.c:transform_axes() static
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       khali@linux-fr.org, lm-sensors@lm-sensors.org
In-Reply-To: <20060813210012.GK3543@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060813012454.f1d52189.akpm@osdl.org>
	 <20060813210012.GK3543@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/06, Adrian Bunk <bunk@stusta.de> wrote:
> transform_axes() isn't a good name for a global function.
>
> Thankfully, it can simply made static.

Definitely, my mistake.

Acked-by: Shem Multinymous <multinymous@gmail.com>


  Shem
