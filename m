Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbVJaQ7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbVJaQ7H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 11:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbVJaQ7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 11:59:07 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:35176 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932468AbVJaQ7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 11:59:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=l0NSIqIzLtcNLlq/37u3xrNOEPyIjRBnQdP9gjxRTY/3/hXNF8FwcAsftpMx0GOBC5571hrw8xY/W+ABVX4OziuYacYBClvSP/eEg8R5I/DK1fSZqLbeDF+WcUvfTMHL/adDfp5mvX0N9qjgouD0vkPRGEl0eMZRoGD17i3nBPA=
Message-ID: <43664D54.9010303@gmail.com>
Date: Mon, 31 Oct 2005 17:59:00 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051027)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: 7eggert@gmx.de, "li >> \"Kernel, \"" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2579] linux 2.6.* sound problems
References: <53L1x-6dC-13@gated-at.bofh.it> <53L1x-6dC-11@gated-at.bofh.it>
In-Reply-To: <53L1x-6dC-11@gated-at.bofh.it>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert ha scritto:
> Patrizio Bassi <patrizio.bassi@gmail.com> wrote:
> 
>>starting from 2.6.0 (2 years ago) i have the following bug.
> 
> 
>>link: http://bugzilla.kernel.org/show_bug.cgi?id=2579
>>and https://bugtrack.alsa-project.org/alsa-bug/view.php?id=230
>>
>>fast summary:
>>when playing audio and using a bit the harddisk (i.e. md5sum of a 200mb
>>file)
>>i hear noises, related to disk activity. more hd is used, more chicks
>>and ZZZZ noises happen.
> 
> 
> Maybe you just need to tune down unused and non-connected inputs in the
> mixer, especially microphone? Happened to me once.

no, it's good configured, all fields are off
