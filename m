Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264829AbTFBSS7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 14:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264831AbTFBSS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 14:18:59 -0400
Received: from cpmail5.sol.no1.asap-asp.net ([195.225.3.232]:27540 "HELO
	cpmail5.sol.no1.asap-asp.net") by vger.kernel.org with SMTP
	id S264829AbTFBSS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 14:18:58 -0400
Date: Mon, 2 Jun 2003 21:32:23 +0300
Message-ID: <3E5AD46C000710DA@webmail-fi1.sol.no1.asap-asp.net>
In-Reply-To: <Pine.LNX.4.50L0.0306022121240.3303-100000@limbo.dnsalias.org>
From: zipa24@suomi24.fi
Subject: Re: 2.5.70-mm3
To: "LKML" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jun 2003 zipa24@suomi24.fi wrote:

> There is a new ALSA patch available, but it didn't apply cleanly to -mm3.
> If I have time later today I'll see if I can apply only ymfpci-related
> changes and if they help.

The newest ALSA patch touched two ymfpci files, and when I applied them everything
works fine, so I'd expect next -mm work, too.

// /

_____________________________________________________________
Kuukausimaksuton nettiyhteys: http://www.suomi24.fi/liittyma/
Yli 12000 logoa ja soitto‰‰nt‰: http://sms.suomi24.fi/


