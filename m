Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbTDIJ20 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 05:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbTDIJ20 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 05:28:26 -0400
Received: from mail.mediaways.net ([193.189.224.113]:475 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S262982AbTDIJ2X (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 05:28:23 -0400
Subject: 2.4.21pre6 devfs + bluez: could not append to parent, err: -17
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1049881076.2773.68.camel@fortknox>
Mime-Version: 1.0
Date: 09 Apr 2003 11:37:56 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get:

devfs_register(bluetooth/rfcomm/0): could not append to parent, err: -17

on bootup on 2.4.21pre6 kernel using usb bt adaptor ... however
everything works OK...

Soeren.

