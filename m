Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275620AbTHOBXq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 21:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275630AbTHOBXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 21:23:18 -0400
Received: from quechua.inka.de ([193.197.184.2]:44955 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S275620AbTHOBXR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 21:23:17 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Double-Harvard Architectures
In-Reply-To: <200308150226.36787.akon@gmx.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.20-xfs (i686))
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <E19nTJC-0006OZ-00@calista.inka.de>
Date: Fri, 15 Aug 2003 03:23:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200308150226.36787.akon@gmx.net> you wrote:
> DH means, that the µprocessor (typically a DSP) has a seperated program 
> memory, a seperate (X)Data memory and a seperate (Y)Data mem, so it can 
> fetch two data adresses simultanely in one cycle via two physically 
> independent mem ports. For DSPs, that's a common behaviour!

Is this an embedded syste which has only the DSP, or is this a DSP add on
card for a PC? In the later case it migh be easier to write an device
driver.

Do you habe GCC support for your intended hardware?

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
