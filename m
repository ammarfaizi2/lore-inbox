Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265364AbUATLaM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 06:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265371AbUATLaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 06:30:11 -0500
Received: from quechua.inka.de ([193.197.184.2]:46504 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S265364AbUATLaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 06:30:07 -0500
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: [BK PATCH] Driver Core update for 2.6.1
Date: Tue, 20 Jan 2004 12:13:04 +0100
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Message-Id: <pan.2004.01.20.11.13.03.678243@dungeon.inka.de>
References: <20040120011036.GA6162@kroah.com> <yw1xsmibovwp.fsf@ford.guide>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jan 2004 08:49:50 +0000, Måns Rullgård wrote:

> Greg KH <greg@kroah.com> writes:
> 
>>   o ALSA: add sysfs class support for ALSA sound devices
> 
> This is still only completed for the intel8x0 driver, right?

I have an maestro3 sound chip, and
/sys/class/sound/ contains device information for both
oss emulation and alsa devices. 

Andreas

