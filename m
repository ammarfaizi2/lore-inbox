Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbUKCWFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbUKCWFY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 17:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbUKCWEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 17:04:43 -0500
Received: from mproxy.gmail.com ([216.239.56.243]:6803 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261927AbUKCV6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:58:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=bHoVQtSVYfZ4SUIjtZcWfJpLvPxsaHwEGJSpG/eoYPsEE46Cj/KSpCoS4dhtL5gTN0RvXvDNi52eO9D9Kgfzr0iSOaTF8/6zaa9+uU/Lv7p2KPwuAnfcCK/dJf4Vljy6XvXme28ZAjlGAsvoTvBZwwKaY4pTVjfhb7sSxmfQrbw=
Message-ID: <21d7e99704110313583cccde5f@mail.gmail.com>
Date: Thu, 4 Nov 2004 08:58:31 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: John McGowan <jmcgowan@inch.com>
Subject: Re: Kernel 2.6.9: i810 video
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041102215308.GA3579@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041102215308.GA3579@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In kernel 2.6.9 it seems that the Intel i810 video driver is useless (junk
> on the screen ... lockup) and one can no longer compile alsa-lib-1.0.6 from
> the source at alsa-project.org. That's as far as I got before I now have to
> recompile the working 2.6.7 (if only gimp worked with it ...).
> 

Is that the i810 framebuffer? or the i810 drm?

Dave.
