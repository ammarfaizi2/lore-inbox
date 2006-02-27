Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWB0Otk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWB0Otk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 09:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWB0Otk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 09:49:40 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:43730 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751363AbWB0Otj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 09:49:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=UlqYL714rxDaB/c+YX/fO81ZEB0iuy+cX8oaIcZ128JMBEWMB7F2iR7lpQ+kleHxDcZS188CYI+Jhq1ufhf/lCtpFk06Xzdequ8VFzhfSVUC8y7zzRTlrXubWVr8/seB+kuNuEs+lnUi2HgtflJ6L1wvge1IRBv21HP6QjMxn64=
Date: Mon, 27 Feb 2006 15:49:21 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Otavio Salvador <otavio@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ALSA HDA Intel stoped to work in 2.6.16-*
Message-Id: <20060227154921.cd554398.diegocg@gmail.com>
In-Reply-To: <87wtfhx7rm.fsf@nurf.casa>
References: <87wtfhx7rm.fsf@nurf.casa>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 27 Feb 2006 10:15:25 -0300,
Otavio Salvador <otavio@debian.org> escribió:

> Hello,
> 
> I was using 2.6.15 without trouble but wanna try the new 2.6.16
> version so I compiled it by myself without much hassle. All worked
> fine but ALSA.

What 2.6.16-rc version did you test, could you try -rc5 if you
tried an earlier version?

(also, include dmesg of the non-working version, etc)
