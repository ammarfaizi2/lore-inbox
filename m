Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262646AbSLFNmA>; Fri, 6 Dec 2002 08:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbSLFNmA>; Fri, 6 Dec 2002 08:42:00 -0500
Received: from [212.41.247.32] ([212.41.247.32]:51183 "EHLO falke.mail")
	by vger.kernel.org with ESMTP id <S262646AbSLFNl7>;
	Fri, 6 Dec 2002 08:41:59 -0500
Message-ID: <3DF0AA36.7050401@winischhofer.net>
Date: Fri, 06 Dec 2002 14:46:30 +0100
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-C
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: SiS framebuffer compile fail
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MDRemoteIP: 10.0.0.13
X-Return-Path: thomas@winischhofer.net
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


James Simmons wrote:
 > > I can confirm that the SIS framebuffer code still doesn't compile in
 > > (vanilla) 2.5.50, my compile error looks the same as was reported
 > > below.
 >
 > Ug!!! I just tested it with my latest work. It needs to be updated to
 > the latest api which is in my last patch.

I will do this as soon as the API is

1) final and

2) in the stock kernel.

I don't have the time to fiddle with new fbdev patches and produce new 
drivers for every fbdev update.

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net            http://www.winischhofer.net/




