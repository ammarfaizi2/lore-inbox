Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265466AbTLHQB4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 11:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265476AbTLHQB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 11:01:56 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:30147 "HELO
	cenedra.office") by vger.kernel.org with SMTP id S265466AbTLHQAh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 11:00:37 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: State of devfs in 2.6?
Date: Mon, 8 Dec 2003 15:59:04 +0000
User-Agent: KMail/1.5.4
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com>
In-Reply-To: <20031208154256.GV19856@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312081559.04771.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 Dec 2003 3:42 pm, William Lee Irwin III wrote:
>
> I would say it's deprecated at the very least. sysfs and udev are
> supposed to provide equivalent functionality, albeit by a somewhat
> different mechanism.
>

Thanks for the pointer. 

So how good is the device coverage offered by sysfs/udev ? Do they provide a 
viable/complete MAKEDEV replacement yet?

