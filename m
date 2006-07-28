Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161179AbWG1OhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161179AbWG1OhP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 10:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161178AbWG1OhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 10:37:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:44417 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161179AbWG1OhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 10:37:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B8zVGX4jSDRy4oYLpyYx/QHcMTVrEovuLt4b8wDy3LY7mY80tNRDz4ilF+Mo3shNTj5zEa8UvcImAhe4cYPWnDa4qEETNooC81csESXh4IvEyaTUBVePR7OtTfZcFryAB9KBMFzJq2/QiPgW5UsbX51BSL/TshrWkQ0V5Zmu0uE=
Message-ID: <d120d5000607280737q4304a850u8709a46b3ac60056@mail.gmail.com>
Date: Fri, 28 Jul 2006 10:37:12 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Komal Shah" <komal_shah802003@yahoo.com>
Subject: Re: [PATCH 1/2] OMAP: Add keypad driver #4
Cc: akpm@osdl.org, juha.yrjola@solidboot.com, tony@atomide.com,
       ext-timo.teras@nokia.com, r-woodruff2@ti.com,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       dbrownell@users.sourceforge.net, kjh@hilman.org,
       rmk+lkml@arm.linux.org.uk
In-Reply-To: <1154096354.24583.267091216@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1154096354.24583.267091216@webmail.messagingengine.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/06, Komal Shah <komal_shah802003@yahoo.com> wrote:
> Andrew/Tony/Rusell/Dmitry,
>
> This is a revised patch as per the review comments from the RMK
> on thread:
>
> http://lkml.org/lkml/2006/7/27/28
>
> Please review it and give me the Ack if looks ok.
>

Input portion is fine now, so:

Acked-by: Dmitry Torokhov <dtor@mail.ru>

-- 
Dmitry
