Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271353AbTHRJv4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 05:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271363AbTHRJv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 05:51:56 -0400
Received: from gw-nl5.philips.com ([212.153.235.109]:61176 "EHLO
	gw-nl5.philips.com") by vger.kernel.org with ESMTP id S271353AbTHRJvz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 05:51:55 -0400
Message-ID: <3F40A202.60701@basmevissen.nl>
Date: Mon, 18 Aug 2003 11:53:06 +0200
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-rc2-ac3
References: <200308162139.h7GLdW415121@devserv.devel.redhat.com>
In-Reply-To: <200308162139.h7GLdW415121@devserv.devel.redhat.com>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> Linux 2.4.22-rc2-ac3

Cool. But a few questions:

1) Can you supply (automatically created) incremental patches? It saves 
a lot of time to just be able to apply the increments in a (manually) 
patched up tree. Furthermore, it saves download time as it is a huge 
patch (POTS modem...).

2) What about the new scheduler? Is that a candidate for 2.4.23 (or even 
2.4.22)? I'm asking this because I'm playing around with swsusp patches 
(created for 2.4.21) and the new scheduler in -ac breaks a few things 
there. If is is a candidate for 2.4.xx real soon, then we need to fix 
it. Otherwise, it can be postponed.

Regards,

Bas.



