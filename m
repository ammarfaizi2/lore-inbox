Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbTDHNFc (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 09:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbTDHNFc (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 09:05:32 -0400
Received: from tomts7.bellnexxia.net ([209.226.175.40]:19945 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261359AbTDHNFb (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 09:05:31 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.67-mm1
Date: Tue, 8 Apr 2003 09:17:15 -0400
User-Agent: KMail/1.5.9
References: <20030408042239.053e1d23.akpm@digeo.com>
In-Reply-To: <20030408042239.053e1d23.akpm@digeo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200304080917.15648.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This does not boot here.  I loop with the following message. 

i8042.c: Can't get irq 12 for AUX, unregistering the port.

irq 12 is used (correctly) by my 20267 ide card.  My mouse is
usb and AUX is not used.

Ideas?

Ed Tomlinson
