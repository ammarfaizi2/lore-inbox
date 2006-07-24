Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWGXMti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWGXMti (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 08:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWGXMti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 08:49:38 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:20492 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932138AbWGXMti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 08:49:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=eJDa3e6DyNnhb6CfSM1u0Gz1uyn3awsCT0bdpOdUPwz9W5Rfy+j8tUKNLQNyMKm7bEk7Q4ebIK/HLNJpux/2Vk3VpUNPMc5Zu60Ukjk6xWZy05dqXz89e510P+lz5yL6FYeAH4LKmo0iZdB/e4URDLpmXfUiWfoUgRWwVw21Zdc=
Message-ID: <44C4C1CE.2030704@gmail.com>
Date: Mon, 24 Jul 2006 20:49:18 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Guido Guenther <agx@sigxcpu.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] rivafb/nvidiafb: race between register_framebuffer and
 *_bl_init
References: <20060722162821.GA4791@bogon.ms20.nix> <20060722163657.GA5699@bogon.ms20.nix> <44C411A2.4030904@gmail.com> <20060724121552.GA19600@bogon.ms20.nix>
In-Reply-To: <20060724121552.GA19600@bogon.ms20.nix>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guido Guenther wrote:
> On Mon, Jul 24, 2006 at 08:17:38AM +0800, Antonino A. Daplas wrote:
>> Guido Guenther wrote:
>>
>> Please add your Signed-off-by:
> It's at the very bottom of the patch already.

Okay, my script missed it.  This line should be after the changelog text.

Tony
