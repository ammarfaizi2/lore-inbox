Return-Path: <linux-kernel-owner+w=401wt.eu-S932517AbWLMRrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbWLMRrW (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 12:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932645AbWLMRrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 12:47:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:3168 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932574AbWLMRrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 12:47:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P2XpqRtbk6yh83sTTIUFGbtDDzK88QfuaI2kSKChfxI+0hLXfZifkgdGBuGU1zi4MDeKAdnVtWeHD8C9Rw5T0G0rosSfoz/SF4o+GBwth/CGdrnPwYthDd5nEAkbV96fL/VnqeXPN0li4eK+4iDAMWDVCq19YRxkpyZtmM6ACYc=
Message-ID: <d120d5000612130947w899614y68cf32cb1e3b35ec@mail.gmail.com>
Date: Wed, 13 Dec 2006 12:47:20 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Andres Salomon" <dilinger@debian.org>
Subject: Re: [PATCH] psmouse split
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz, warp@aehallh.com
In-Reply-To: <45802D98.7030608@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <457F822E.4040404@debian.org>
	 <200612130108.19447.dtor@insightbb.com> <457FAA01.9010807@debian.org>
	 <d120d5000612130612v5d12adc0uc878b8307770d79@mail.gmail.com>
	 <45802D98.7030608@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/06, Andres Salomon <dilinger@debian.org> wrote:
>
> Alright, I guess we're down to a matter of taste then.  I'll change the
> patch to still have a monolithic psmouse that allows protocols to be
> enabled/disabled via Kconfig.
>

That'd be great. Thanks!

-- 
Dmitry
