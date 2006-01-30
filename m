Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWA3NsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWA3NsO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 08:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWA3NsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 08:48:13 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:55234 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932272AbWA3NsN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 08:48:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SuOSzu533Yvcnhl+KjsjaOmKlFP0qVcUAdFedOt/zwrmQlE9xE+S6o2u5QW4bsGQhRShYC36EyuwO4g+/Tlnlm3B+I1wtnxyVLF5VsOVfdpaxMKY8EYIaAp0WhgyAvac/MNOUrWUELx1g3tCUbrZejgNSRLuqMvx3crogJ6h6mU=
From: Marek =?utf-8?q?Va=C5=A1ut?= <marek.vasut@gmail.com>
To: dtor_core@ameritech.net
Subject: Re: [PATCH] iforce: fix -ENOMEM check
Date: Mon, 30 Jan 2006 14:47:52 +0100
User-Agent: KMail/1.7.2
References: <200601281903.28176.marek.vasut@gmail.com> <200601291209.15864.marek.vasut@gmail.com> <200601292226.51488.dtor_core@ameritech.net>
In-Reply-To: <200601292226.51488.dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601301447.52382.marek.vasut@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dne pondělí 30 ledna 2006 04:26 jste napsal(a):
> OK, the patch below should get it going... Please let me know if it makes
> device appear.
Yeah, it works :-)
Thanks a lot. Maybe this fix should get somehow in kernel tree.
