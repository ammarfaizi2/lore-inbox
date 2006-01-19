Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422646AbWASWIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422646AbWASWIH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422656AbWASWIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:08:07 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:9991 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422646AbWASWIG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:08:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=imlAsZy6jDyn23esKXd+zRb/qqjiM3AHagZoH1V+6gNhNNDs098orrdyJ0A72TlCGdrf9IZijbBjkn7GVACmDgp+JMYM2gEhZ4aj8YizYYtoca3YeAfRhgXDKtYIrvU6Ihuf5+/8QwuvJVG7/22WlF2BDMaFzL06K8WhC5mcuEE=
Date: Thu, 19 Jan 2006 23:07:46 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: pppd oopses current linu's git tree on disconnect
Message-Id: <20060119230746.ea78fcf4.diegocg@gmail.com>
In-Reply-To: <1137692039.3279.1.camel@amdx2.microgate.com>
References: <20060119010601.f259bb32.diegocg@gmail.com>
	<1137692039.3279.1.camel@amdx2.microgate.com>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 19 Jan 2006 11:33:59 -0600,
Paul Fulghum <paulkf@microgate.com> escribió:

> Can you try the attached patch please?
> Does this occur frequently?

Not at all - I've tried to trigger it tons of times and didn't happen again,
I even put a pon/poff in a loop but nothing happened; so I can't confirm if
your patch does fix it, but I'm running the patch and nothing bad seems to
happen.
