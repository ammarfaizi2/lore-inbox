Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVBRDcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVBRDcj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 22:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVBRDci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 22:32:38 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:11651 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261232AbVBRDch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 22:32:37 -0500
Message-ID: <421561C1.1050406@nortel.com>
Date: Thu, 17 Feb 2005 21:32:17 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: parker@citynetwireless.net
CC: arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Please open sysfs symbols to proprietary modules
References: <20050217231304.GA18940@core.citynetwireless.net>
In-Reply-To: <20050217231304.GA18940@core.citynetwireless.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

parker@citynetwireless.net wrote:
> On Thu, 03 Feb 2005 09:41:00 +0100, Arjan van de Ven <arjan@infradead.org> wrote:

>>I suggest you talk to a lawyer and review the general comments about
>>binary modules with him (http://people.redhat.com/arjanv/COPYING.modules
>>for example). You are writing an addition to linux from scratch, and it
>>is generally not considered OK to do that in binary form (I certainly do
>>not consider it OK).

> So what about companies like ImageStream who write proprietary Linux network
> drivers for their hardware from scratch with no previous ports from another OS?

Obviously he doesn't consider that to be okay, and those companies are 
taking a risk that someone will take legal action against them.

Chris
