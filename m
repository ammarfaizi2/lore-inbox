Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277849AbRJRRfW>; Thu, 18 Oct 2001 13:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277836AbRJRRfM>; Thu, 18 Oct 2001 13:35:12 -0400
Received: from mailproxy.de.uu.net ([192.76.144.34]:64489 "EHLO
	mailproxy.de.uu.net") by vger.kernel.org with ESMTP
	id <S277842AbRJRRex>; Thu, 18 Oct 2001 13:34:53 -0400
Message-Id: <200110181735.TAA05357@mailproxy.de.uu.net>
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Patrick Mochel <mochelp@infinity.powertie.org>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Thu, 18 Oct 2001 19:38:01 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.21.0110180826240.16868-100000@marty.infinity.powertie.org>
In-Reply-To: <Pine.LNX.4.21.0110180826240.16868-100000@marty.infinity.powertie.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 October 2001 18:19, Patrick Mochel wrote:
> Hmm. So, this would be a device ID, much like the Vendor/Device ID pair in
> PCI space? Does this need to happen at the top layer, or can it work at
> the bus layer?

Probably both. See this discussion on device ids (from linux-hotplug-devel):

http://www.geocrawler.com/archives/3/9005/2001/9/0/6716219/
http://www.geocrawler.com/mail/thread.php3?subject=IDs+%28was+Re%3A+Hotplugging+for+the+input+subsystem%29&list=9005

bye...
