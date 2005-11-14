Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbVKNXvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbVKNXvE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 18:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbVKNXvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 18:51:04 -0500
Received: from web52912.mail.yahoo.com ([206.190.49.22]:21383 "HELO
	web52912.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932172AbVKNXvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 18:51:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=c8mPKbU89cuYZ33c1A0TWQj9POjDm0H7t0y6tjcwXv5FCJLDS4g0ewWYSjChu0uqOBDKf8vM7VomvzDNd5+cuL0tkJ3KsaUVmGhZhSVqPkjeHU360lfc2J4s6xl+0cxrgRK4QwYxEtEBRSDA7DfHSzKdp9xpZgvp4sQ7Pdt39yA=  ;
Message-ID: <20051114235102.64514.qmail@web52912.mail.yahoo.com>
Date: Mon, 14 Nov 2005 23:51:02 +0000 (GMT)
From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: [OOPS] Linux 2.6.14.2 and DVB USB
To: David Brigada <brigad@rpi.edu>
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
In-Reply-To: <20051114233924.GA9772@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- David Brigada <brigad@rpi.edu> wrote:
> It seems as though there were messages that were still being sent to and
> from your device when you disconnected it.  Try to make sure that you
> quit all the software that was using the device,

I'm fairly certain that I'd shut xine down.

> and if possible, remove
> the kernel module that the device uses before removing the device.

This sounds contrary to the entire concept of hotplugging to me. And I don't think that a typical
desktop user would be happy to be told that s/he needs to become root and unload kernel modules
before s/he can unplug a USB device.

Cheers,
Chris



		
___________________________________________________________ 
To help you stay safe and secure online, we've developed the all new Yahoo! Security Centre. http://uk.security.yahoo.com
