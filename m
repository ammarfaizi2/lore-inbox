Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265113AbTFYWVt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 18:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265117AbTFYWVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 18:21:49 -0400
Received: from cmu-24-35-32-166.mivlmd.cablespeed.com ([24.35.32.166]:772 "EHLO
	lap.molina") by vger.kernel.org with ESMTP id S265113AbTFYWVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 18:21:47 -0400
Date: Wed, 25 Jun 2003 18:34:12 -0600 (CST)
From: Thomas Molina <tmolina@copper.net>
X-X-Sender: tmolina@lap.molina
To: linux-kernel@vger.kernel.org
Subject: Synaptics support kills my mouse
Message-ID: <Pine.LNX.4.44.0306251818180.3272-100000@lap.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since about 2.5.72 the "new?" synaptics touchpad support kills my system.  
I have a Compaq Presario 12XL325, which does have a synaptics touchpad, 
but has always acted like a regular PS/2 mouse.  The last version  of the 
kernel which worked correctly in this respect was 2.5.72 bitkeeper as of 
June 18.  The next version I was able to test was 2.5.73 as of June 24.  
>From this version forward I get no mouse at all.  My recollection is that 
the June 18 bitkeeper version had optional synaptics support; including 
it broke mouse support, but compiling it with only ps/2 support enabled 
the mouse support.  

