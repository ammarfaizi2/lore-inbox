Return-Path: <linux-kernel-owner+w=401wt.eu-S965065AbXAJUJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbXAJUJc (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 15:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbXAJUJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 15:09:31 -0500
Received: from smtp.osdl.org ([65.172.181.24]:48028 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965065AbXAJUJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 15:09:30 -0500
Date: Wed, 10 Jan 2007 12:08:25 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Florian Lohoff <flo@rfc822.org>
Cc: netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.20-rc4 sky2 unsupported chip type 0xff / phy write timeout
Message-ID: <20070110120825.693dc28c@freekitty>
In-Reply-To: <20070110095528.GA14947@paradigm.rfc822.org>
References: <20070110095528.GA14947@paradigm.rfc822.org>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2007 10:55:28 +0100
Florian Lohoff <flo@rfc822.org> wrote:

> 
> Hi,
> i have random problems after fresh boot with the onboard sky2 on an
> Fujitsu Siemens Lifebook E8110. With 2.6.18-686-3 from the Debian repository i see
> random crashes on boot - see http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=404107
> 
> 

Does the vendor driver work?
	http://www.syskonnect.de/e_en/support/driver.html



-- 
Stephen Hemminger <shemminger@osdl.org>
