Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWI3RMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWI3RMg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 13:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWI3RMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 13:12:36 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:25925 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751306AbWI3RMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 13:12:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=apg2zimWVzGq+bG3bRPHqAOsLlYtWkBVuBUmFvPGW/r5NXkL1JHCSRe9mAJyeodEqCN4yhcuVJbJg9B8Ae38Po0HPE7INfVEcANN6YPpau0FW7hL0ludNE5VRvz5o4MVdshLiBRo7gBWUiI5s/15Vwp53MNntacOoY2ydlCBkyI=
Date: Sat, 30 Sep 2006 19:14:57 +0200
From: Alessandro Guido <alessandro.guido@gmail.com>
To: Alessandro Guido <alessandro.guido@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net,
       ismail@pardus.org.tr
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi
 driver
Message-Id: <20060930191457.a120ff56.alessandro.guido@gmail.com>
In-Reply-To: <20060930190810.30b8737f.alessandro.guido@gmail.com>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Sep 2006 19:08:10 +0200
Alessandro Guido <alessandro.guido@gmail.com> wrote:

> Make the sony_acpi use the backlight subsystem to adjust brightness value
> instead of using the /proc/sony/brightness file.
> (Other settings will still have a /proc/sony/... entry)

I meant /proc/acpi/sony/brightness and /proc/acpi/sony/...

sorry
