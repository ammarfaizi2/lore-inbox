Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbUCXQbF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 11:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263760AbUCXQbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 11:31:05 -0500
Received: from main.gmane.org ([80.91.224.249]:47503 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263765AbUCXQbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 11:31:02 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Mark McPherson <mark@mahonia.com>
Subject: Re: 2.6.5-rc2-mm2
Date: Wed, 24 Mar 2004 07:43:26 -0800
Message-ID: <pan.2004.03.24.15.43.26.49349@mahonia.com>
References: <20040323232511.1346842a.akpm@osdl.org> <406194D4.9030904@aitel.hist.no> <1080137982.5296.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mahonia.com
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2004 15:19:42 +0100, Arjan van de Ven wrote:

> On Wed, 2004-03-24 at 15:01, Helge Hafting wrote:
>> Andrew Morton wrote:
>> 
>> 2.6.5-rc2-mm2 hung during boot for me.
>> The last messages was
>> Setting up ICE socket directory ... done
>> 
>> which is from the xserver-common init script
> 
> are you using the nvidia modules ?


Hi,

In the hallowed spirit of "me too" --

I'm getting the same failure and am *not* using nVidia modules.  I do have
an nforce2 mobo with disabled integrated video, but am using an ATI 9000
to drive the display.

Cheers,
Mark


