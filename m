Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbVAOBsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVAOBsR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 20:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVAOBlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 20:41:07 -0500
Received: from [81.2.110.250] ([81.2.110.250]:44521 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262118AbVAOBir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 20:38:47 -0500
Subject: Re: usb key oddities with 2.6.10-ac9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jack Howarth <howarth@bromo.msbb.uc.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050114145837.6AB211DC357@bromo.msbb.uc.edu>
References: <20050114145837.6AB211DC357@bromo.msbb.uc.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105745243.9838.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 15 Jan 2005 00:33:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-01-14 at 14:58, Jack Howarth wrote:
> does appear in the Gnome desktop's Computer folder. However if one
> removes and reinserts the key it disappears and doesn't come back.
> I see the same kernel messages as I did under 2.6.7 when I insert
> the memory key...

Make sure you have the hotplug notification stuff all enabled in the
kernel. Missing that can produce the symptoms you describe

